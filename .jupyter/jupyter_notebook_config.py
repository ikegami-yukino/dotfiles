# -*- coding: utf-8 -*-
import sys


# Allowed IP
c.NotebookApp.ip = '*'
# Password
c.NotebookApp.password = 'sha1:e9d9dd1458e6:67dbfdf680315c697318a767c4e30943ca6eae8e'

if sys.platform == 'darwin':
    c.NotebookApp.browser = u'open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome %s'
