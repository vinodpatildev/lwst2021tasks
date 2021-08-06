#!/usr/bin/python3

print("content-type: text/html")
print()

import subprocess as sp
import cgi

fs = cgi.FieldStorage()

cmd = fs.getvalue("command")
output = sp.getoutput("sudo "+cmd)
print(output)
