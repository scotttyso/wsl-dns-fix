$outItems = @()
$netadapters = Get-NetAdapter | Select-Object *
if ($netadapters | Where-Object {( $_.ifDesc -match "Cisco Anyconnect") -and ($_.Status -eq "Up")}) {
    Write-Host "!!! AnyConnect is Up !!!"
    $adapter = $netadapters | Where-Object {$_.ifDesc -match "Cisco Anyconnect"}
    Write-Host "  * Setting Anyconnect Interface Metric."
    $adapter | Set-NetIPInterface -InterfaceMetric 6000
    Write-Host "  * Getting DNS Servers from AnyConnect Connection."
    $outItems += , $adapter | Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses
} else {
    Write-Host "!!! AnyConnect is Down !!!"
    Write-Host "  * Getting DNS Servers from Other Connections."
    foreach($adapter in $netadapters) {
        if (!($adapter | Where-Object {$_.ifDesc -match "Cisco Anyconnect"})) {
            $outItems += , $adapter | Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses
        }
    }
}
$dns_servers = $outItems | Sort-Object | Get-Unique

Set-Content -Path C:\Users\Public\resolv.conf -Value "# Generated by VPN fix on $(Get-Date -Format "dddd MM/dd/yyyy HH:mm K")"
Add-Content -Path C:\Users\Public\resolv.conf -Value ""

foreach($i in $dns_servers) { Add-Content -Path C:\Users\Public\resolv.conf -Value "nameserver $i" }
Add-Content -Path C:\Users\Public\resolv.conf -Value "search rich.ciscolabs.com cisco.com"