#! /usr/bin/env python3
# -*- coding: iso-8859-1 -*-

################################################
#TODO: Remove this code after testing!!
import cgitb
cgitb.enable()
################################################

import os, cgi
from PIL import Image

input = cgi.FieldStorage()
webDir = '/website'
picDir = '/pics/'
size = 160, 120 #thumbnail size

try:
    path = input['path'].value
    print("""
    <html>
    <head>
    <meta charset="utf-8" />
    <title>""")
    print(path)
    print("""</title>
    <link rel="stylesheet" type="text/css" href="/pictures/pic.css" />
    <link rel="stylesheet" href="/thirdparty/fancybox/source/jquery.fancybox.css?v=2.1.0" type="text/css" media="screen" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="/thirdparty/fancybox/source/jquery.fancybox.pack.js?v=2.1.0"></script>
    <script type="text/javascript" src="/thirdparty/fancybox/lib/jquery.mousewheel-3.0.6.pack.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".fbox").fancybox();
        });
    </script>
    </head>
    
    <body>""")
    
    print('<h1>',path,'</h1>')
    for file in os.listdir(webDir+picDir+path):
       if os.path.isdir(webDir+picDir+path+'/'+file):
          print ("<a href=\"framethumbnails.py?path=%s\" target=\"thumbnails\">%s</a><br />" % (path+'/'+file,file))
    
    print('<table border="3">')
    mylist = []
    
    for file in os.listdir(webDir+picDir+path):
       if ('.jpg' in file) or ('.JPG' in file) or ('.MPG' in file) or ('.MOV' in file) or ('.3gp' in file):
          if file[0] != '_':
             mylist.append(file)
    
    while len(mylist) > 0:
       print("<tr>")
       for j in range(4):
          if len(mylist) == 0:
             break
          i = mylist.pop()
          thumb = picDir+path+'/'+i[:-3]+'THM'
          if ('.jpg' in i) or ('.JPG' in i):
             #new stuff: taken from PIL tutorial
             if not os.path.exists(webDir+thumb):
                image = Image.open(webDir+picDir+path+'/'+i)
                image.thumbnail(size)
                image.save(webDir+thumb, "JPEG")
             print("<td><a href=\"%s%s/%s\" class=\"fbox\" rel=\"group\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a></td>" % (picDir,path,i,thumb,i,i))
          elif (os.path.exists(webDir+thumb)):
             print("<td  class=\"movie\"><a href=\"%s%s/%s\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a></td>" % (picDir,path,i,thumb,i,i))
          else:
             print("<td class=\"movie\"><a href=\"%s%s/%s\">%s</td>" % (picDir,path,i,i))
       print("</tr>")
          
    print("</table>")
    
    print("""</body>
    </html>""")
except:
    print("""
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="/pictures/pic.css" />
            </head>
            <body>
                <hgroup>
                    <h1 id="title">Jeter Family Digital Photo Album</h1>
                    <h2 id="subtitle">(select a folder from the pullout menu to the left)</h2>
                </hgroup>
            </body>
        </html>
    """)
