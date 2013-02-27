#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, cgi

################################################
#TODO: Remove this code after testing!!
import cgitb
cgitb.enable()
################################################

# source for python3 PIL package: http://www.lfd.uci.edu/~gohlke/pythonlibs/#pil
from PIL import Image

# configuration parameters
WEB_ROOT = '/website' #root directory of the webserver
PIC_URL = '/pics/' #root directory of the media
thumb_size = (160, 120) #thumbnail size

# functions
def get_directories(path):
    """Gets a list of non-hidden subdirectories.
    
    Args:
        path: The root path to search.
        
    Returns:
        A list of directories contained within 'path' deliniated with '|'s.
    """
    
    return "|".join(_directory_list(path))


#def get_hgroup(path):
#    #is this server stuff, or javascript stuff? probably javascript.
#    print ('<h1>', path, '</h1>')
#    for file in os.listdir(webDir+picDir+path):
#       if os.path.isdir(webDir+picDir+path+'/'+file):
#          print ("<a href=\"framethumbnails.py?path=%s\" target=\"thumbnails\">%s</a><br />" % (path+'/'+file,file))

def media_count(path):
    """Returns the number of media items in the directory.
    
    The total number of image and video items (excludes .THM and files
    hidden with a leading underscore(_)) is returned.
    """
    return len(_thumb_list(path))

def get_thumbnails(path, quantity=-1, first_index=0):
    """Gets thumbnail images for the specified image or video.
    
    This service returns the requested number of thumbnail images of the
    images and videos contained within the path directory as anchor tags
    complete with the path specified for the actual image. If thumbnails
    of the images don't already exist, they will be created.
    
        ***code expects all extensions to be 3 characters long!!

    Args:
        path:
        
        quantity:
        
        first_index:
        
    Returns:
        Thumbnail links delinated by '|' or '' if thumnails don't exist and cannot
        be created.
        example output: <a [class="media"] href=[web path]><img src="[thumb source]"></a>|

    """
    thumbnails = []
    mylist = _thumb_list(path, quantity, first_index)
    
    while len(mylist) > 0:
        i = mylist.pop()
        thumb = PIC_URL+path+'/'+i[:-3]+'THM'
        if ('.jpg' in i) or ('.JPG' in i):
            if not os.path.exists(WEB_ROOT+thumb):
                image = Image.open(WEB_ROOT+PIC_URL+path+'/'+i)
                image.thumbnail(thumb_size)
                image.save(WEB_ROOT+thumb, "JPEG")
            thumbnails.append("<a href=\"%s%s/%s\" class=\"fbox\" rel=\"group\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a>" % (PIC_URL,path,i,thumb,i,i))
        elif (os.path.exists(WEB_ROOT+thumb)):
            thumbnails.append("<a href=\"%s%s/%s\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a>" % (PIC_URL,path,i,thumb,i,i))
        else:
            thumbnails.append("<a href=\"%s%s/%s\">%s</td>" % (PIC_URL,path,i,i))

    return "|".join(thumbnails)
    
#this may not be required & totally inadaquate, anyway
#hopefully apache/lighttpd will restrict the the searching, but perhaps
#an input of /../pictures will give a list of files in other parts of the web
#directory?
def clean_path(path):
    while '..' in path:
        path.replace('..', '')

def _directory_list(path):
    directories = []
    files = os.listdir(WEB_ROOT+PIC_URL + path)
    files.sort()
    
    for file in reversed(files):
        if os.path.isdir(WEB_ROOT+PIC_URL + path + '/' + file):
            if file[0] != '_':
                directories.append(file)
    return directories

def _thumb_list(path, quantity, first_index):
    mylist = []
    
    for file in os.listdir(WEB_ROOT+PIC_URL+path):
        #TODO: these media extensions need to be replaced by a tuple constant
        if ('.jpg' in file) or ('.JPG' in file) or ('.MPG' in file) or ('.MOV' in file) or ('.3gp' in file):
            if file[0] != '_':
                mylist.append(file)
    return mylist


#####################################
# Process the request from here.
# parse the url and call the function

# Dictionary.pop() is used to remove the parameters before passing
# to the specified function (will cause a TypeError if an extra keyword
# parameter is passed to a function which declares all of its kw args)

urlparams = cgi.FieldStorage(keep_blank_values=True) #param set in case things like 'path' are blank
if 'width' in urlparams and 'height' in urlparams:
    thumb_size = (urlparams.pop('width'), urlparams.pop('height'))
function = locals()[urlparams.pop('function')]
try:
    print(function(**urlparams))
except TypeError as error:
    print(error + " please review the documentation for the correct parameters to use.")