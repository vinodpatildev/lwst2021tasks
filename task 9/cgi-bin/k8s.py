#!/usr/bin/python3

print("content-type: text/html")
print()

print('''<style>
pre{
  color: black;
  font-weight: bold;
  font-size: 20px;
}
</style>
''')
import subprocess as sp
import cgi

fs = cgi.FieldStorage()

cmd = fs.getvalue("command")
output = sp.getoutput("sudo "+cmd)
print("<body>")
print('<h1 style="color:#02aab0;" >Output</h1>')
print(cmd)
print("<pre>{}</pre>".format(output))
print("</body>")
