# -*- coding: utf-8 -*-
import sys


if sys.platform == 'darwin':
    c.NotebookApp.browser = u'open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome %s'
