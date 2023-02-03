#!/usr/bin/env python3
import os.path
import sys
from urllib.parse import quote
from subprocess import run
out = [os.fsencode('file://' + quote(os.path.abspath(x))) for x in sys.argv[1:]]
run(['xclip', '-i', '-selection', 'clipboard', '-t', 'text/uri-list'],
    input=b'\n'.join(out), check=True)
