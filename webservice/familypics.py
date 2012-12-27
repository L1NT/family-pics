#! /usr/bin/env python3
# -*- coding: iso-8859-1 -*-

import os, cgi, Image


# this is originally from frameindex.py
path = '/website/pics' #will want to call this dynamically!!

# parse the url and call the function
function = HttpRequest.GET.get('function')
for param in HttpRequest.GET:
   kargs = param.key + '=' + param.value
function(**kargs)

def get_directories(path):
    """Gets a list of non-hidden subdirectories.
    
    Args:
        path: The root path to search.
        
    Returns:
        A list of directories contained within 'path'.
    """
    directories = []
    files = os.listdir(path)
    files.sort()
    
    #this stuff should be in the Javascript ajax function
    for file in reversed(files):
       if os.path.isdir(path + '/' + file):
          if file[0] != '_':
             directories.add(file.name)
    return directories

# this is originaly from framethumbnails.py
input = cgi.FieldStorage()
webDir = '/website'
picDir = '/pics/'
path = input['path'].value
size = 160, 120 #thumbnail size

def get_hgroup(path):
    #is this server stuff, or javascript stuff? probably javascript.
    print '<h1>',path,'</h1>'
    for file in os.listdir(webDir+picDir+path):
       if os.path.isdir(webDir+picDir+path+'/'+file):
          print "<a href=\"framethumbnails.py?path=%s\" target=\"thumbnails\">%s</a><br />" % (path+'/'+file,file)

def media_count(path):
    """Returns the number of media items in the directory.
    
    The total number of image and video items (excludes .THM and files
    hidden with a leading underscore(_)) is returned.
    """
    pass
    
def get_thumbnails(path, quantity=-1, first_index=0):
    """Gets a specified number of thumbnails images.
    
    This service returns the requested number of thumbnail images of the
    images and videos contained within the path directory. If thumbnails
    of the images don't already exist, they will be created.
    
    Args:
        path: The directory containing the requested media items.
        quantity: The number of thumbnails to return, or '-1' for all
            items within the path directory.
        first_index: 
    """
    print '<table border="3">'
    mylist = []
    
    for file in os.listdir(webDir+picDir+path):
       if ('.jpg' in file) or ('.JPG' in file) or ('.MPG' in file) or ('.MOV' in file) or ('.3gp' in file):
          if file[0] != '_':
             mylist.append(file)
    
    while len(mylist) > 0:
       print "<tr>"
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
             print "<td><a href=\"%s%s/%s\" class=\"fbox\" rel=\"group\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a></td>" % (picDir,path,i,thumb,i,i)
          elif (os.path.exists(webDir+thumb)):
             print "<td  class=\"movie\"><a href=\"%s%s/%s\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a></td>" % (picDir,path,i,thumb,i,i)
          else:
             print "<td class=\"movie\"><a href=\"%s%s/%s\">%s</td>" % (picDir,path,i,i)
       print "</tr>"
          
    print "</table>"
