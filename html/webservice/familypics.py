#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import os, sys, cgi, configparser

################################################
#TODO: Remove this code after testing!!
import cgitb
cgitb.enable()
################################################

# source for python3 PIL package: http://www.lfd.uci.edu/~gohlke/pythonlibs/#pil
from PIL import Image

class FamilyPics:
    def __init__(self):
        config = configparser.ConfigParser()
        config.read('familypics.config')
        default_config = config['DEFAULT']

        self.web_root = default_config['WEB_ROOT']
        self.pic_url = default_config['PIC_URL']
        self.extensions = default_config['EXTENSIONS']
        self.cache = default_config['CACHE']

        self.thumb_size = (160, 120) #default thumbnail size
        if not os.path.exists(self.web_root + self.cache):
            os.makedirs(self.web_root + self.cache)

    def get_directories(self, path):
        """Gets a list of non-hidden subdirectories.
        
        Args:
            path: The root path to search.
            
        Returns:
            A list of directories contained within 'path' deliniated with '|'s.
        """
        
        return "|".join(self._directory_list(path))
    
    def media_count(self, path, **kwargs):
        """Returns the number of media items in the directory.
        
        The total number of image and video items (excludes .THM and files
        hidden with a leading underscore(_)) is returned.
        """
        return len(self._thumb_list(path))
    
    def get_thumbnails(self, path, **kwargs):
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
            
            filter:
            
        Returns:
            Thumbnail links delinated by '|' or '' if thumnails don't exist and cannot
            be created.
            example output: <a [class="media"] href=[web path]><img src="[thumb source]"></a>|
        """
        thumbnails = []
        try:
            mylist = self._thumb_list(path, **kwargs)
        except TypeError as error:
            print(error + " :: The get_thumbnails service call only accepts the following arguments: path, quantity, first_index, and filter.")
            return

        while len(mylist) > 0:
            item = mylist.pop()
            cache_thumb = self.cache+path+'/'+item[:item.rfind('.')]+'_'+str(self.thumb_size[0])+'x'+str(self.thumb_size[1])+'.THM'
            pic_dir_thumb = self.pic_url+path+'/'+item[:item.rfind('.')]+'.THM'
            if not os.path.exists(self.web_root + self.cache + path):
                os.makedirs(self.web_root + self.cache + path)
            try:
                #this creates a specific-sized thumbnail in the cache from a jpeg
                if ('.jpg' in item) or ('.JPG' in item):
    #            if item[item.rfind('.'):] in ['jpg', 'JPG']:
                    if not os.path.exists(self.web_root+cache_thumb):
                        image = Image.open(self.web_root+self.pic_url+path+'/'+item)
                        image.thumbnail(self.thumb_size)
                        image.save(self.web_root+cache_thumb, "JPEG")
                    thumbnails.append("<a href=\"%s%s/%s\" class=\"fbox\" rel=\"group\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a>" % (self.pic_url,path,item,cache_thumb,item,item))
                #this creates a thumbnail if a .THM already exists alongside the video item
                elif (os.path.exists(self.web_root+pic_dir_thumb)):
                    if not os.path.exists(self.web_root+cache_thumb):
                        image = Image.open(self.web_root+pic_dir_thumb)
                        image.thumbnail(self.thumb_size)
                        image.save(self.web_root+cache_thumb, "JPEG")
                    thumbnails.append("<a href=\"%s%s/%s\"><img src=\"%s\" alt=\"%s\" title=\"%s\" /></a>" % (self.pic_url,path,item,cache_thumb,item,item))
                else:
                    thumbnails.append("<a href=\"%s%s/%s\">%s</td>" % (self.pic_url,path,item,item))
            except Exception as e:
                thumbnails.append("<!-- the following image failed to open: %s because: %s -->" % (item,e))
    
        return "|".join(thumbnails)
        
    #this may not be required & totally inadaquate, anyway
    #hopefully apache/lighttpd will restrict the the searching, but perhaps
    #an input of /../pictures will give a list of files in other parts of the web
    #directory?
    def _clean_path(self, path):
        while '..' in path:
            path.replace('..', '')
    
    def _directory_list(self, path):
        directories = []
        files = os.listdir(self.web_root+self.pic_url + path)
        files.sort()
        
        for file in reversed(files):
            if os.path.isdir(self.web_root+self.pic_url + path + '/' + file):
                if file[0] != '_':
                    directories.append(file)
        return directories
    
    def _thumb_list(self, path, quantity=-1, first_index=0, filter=None):
        mylist = []
        
        for file in os.listdir(self.web_root+self.pic_url+path):
#TODO: these media extensions need to be replaced by a tuple constant
            if ('.jpg' in file) or ('.JPG' in file) or ('.MPG' in file) or ('.MOV' in file) or ('.3gp' in file):
#            if file[file.rfind('.'):] in self.extensions:
                if file[0] != '_':
                    mylist.append(file)
        return mylist


#####################################
# Process the request from here:
# parse the url and call the function

# Dictionary.pop() is used to remove the parameters before passing
# to the specified function (will cause a TypeError if an extra keyword
# parameter is passed to a function which declares all of its kwargs)
if __name__ == '__main__':
    #param set in case things like 'path' are blank
    urlparams = {}
    cgiparams = cgi.FieldStorage(keep_blank_values=True)
    for key in cgiparams.keys():
        urlparams[key] = cgiparams[key].value
    familypics = FamilyPics()
    if 'width' in urlparams and 'height' in urlparams:
        familypics.thumb_size = (urlparams.pop('width'), urlparams.pop('height'))
    function = getattr(familypics, urlparams.pop('function'))
    print(function(**urlparams))
