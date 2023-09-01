import os, sys, traceback
lib_path = os.path.dirname(traceback.__file__)
sys.path = [lib_path]
import traceback
import re
import numpy
import fcntl
import os
import pickle
import pty
import select
import signal
import socket
import struct
import subprocess
import sys
import tempfile
import time
import traceback
import tty
from contextlib import ExitStack, closing, contextmanager

import termios
#!/usr/bin/python3
import sys
import os

external = set()
exempt = set()
paths = (os.path.abspath(p) for p in sys.path)
stdlib = {p for p in paths
          if p.startswith((sys.prefix, sys.real_prefix)) 
          and 'site-packages' not in p}
for name, module in sorted(sys.modules.items()):
    if not module or name in sys.builtin_module_names or not hasattr(module, '__file__'):
        # an import sentinel, built-in module or not a real module, really
        exempt.add(name)
        continue

    fname = module.__file__
    if fname.endswith(('__init__.py', '__init__.pyc', '__init__.pyo')):
        fname = os.path.dirname(fname)

    if os.path.dirname(fname) in stdlib:
        # stdlib path, skip
        exempt.add(name)
        continue

    parts = name.split('.')
    for i, part in enumerate(parts):
        partial = '.'.join(parts[:i] + [part])
        if partial in external or partial in exempt:
            # already listed or exempted
            break
        if partial in sys.modules and sys.modules[partial]:
            # just list the parent name and be done with it
            external.add(partial)
            break

for name in external:
    print(name, sys.modules[name].__file__)