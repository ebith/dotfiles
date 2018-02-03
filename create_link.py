#!/usr/bin/env python3

import os
import sys

if len(sys.argv) < 2:
    print('Need argument.')
    sys.exit(0)

sys.argv.pop(0)
for arg in sys.argv:
    src = os.path.abspath(arg)
    dst = os.path.expanduser('~/' + arg)
    os.symlink(src, dst)
    print('Symlinked:', src, dst)
