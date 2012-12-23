#! /usr/bin python
# -*- coding: iso-8859-1 -*-

import os

print"""
<html class="nav">

<head>
	<title>Pictures & Videos</title>
	<link rel="stylesheet" type="text/css" href="/pictures/pic.css" />
</head>

<body class="nav">
"""

path = '/website/pics' #will want to call this dynamically!!
files = os.listdir(path)
files.sort()

for file in reversed(files):
   if os.path.isdir(path + '/' + file):
      if file[0] != '_':
         print "<a href=\"framethumbnails.py?path=%s\" target=\"thumbnails\">%s</a><br />" % (file,file)
   
print """
</body>

</html>"""