picture-webservice
==================

What it does:
Turns any file directory containing photos and videos into a web service
capable of serving folder names, thumbnails, and the photos/videos 
themselves.

Development plans:
My current deployed version are Py3 scripts that dynamically return
formatted html. The next (and current) step is to decouple the presentation
and control layers and offer an HTML5 front end that makes calls to
a RESTful web service so that the service can be consumed by other clients.
The next step will likely involve creating an Android interface that
uses the web service, and eventually I may convert the RESTful service
into one which is SOAP- or JSON-formatted.

Licensing:
I haven't bothered to include any specific user license. Anyone is
welcome to use and modify this code to their liking. If you make a 
change or enhancement you think will benefit most or all users, I 
encourage you to submit a pull request. Additionally, any 
acknowledgement that includes my name or a link on your own pages (an 
example can be found on the sample html page(s)) that use this code 
would be greatly appreciated. Thanks!

Usage assumptions:
If you plan to follow these guidelines, it is assumed that you are 
familiar with installing Python modules and configuring your webserver
to run Python scripts and defining web-accessible files/folders.

Requirements:
- > Python 3.1
- Py3-compatible version of PIL must be installed [see http://www.lfd.uci.edu/~gohlke/pythonlibs/#pil]
- included html pages require jQuery and fancybox plugin

Deployment:
- Specify the correct path to a Python3 installation on your system
  in /webservice/familypics.py
- The Webservice folder needs to be in a web-accessible location
- Configure the webservice/familypics.py variable to point to the root
  of your media directory
- If you choose to use the default html pages, set the picservice url
  variable to point to the /webservice directory

Features:
- Any file(s) or folder(s) that should be hidden/ignored by the web
  service can be prefaced with an underscore (_) character
- The directory names are returned in reverse alphanumeric order because
  I use a YYYY-MM naming scheme in my own directories and the most
  recent folders are the most relevant (alter /webservice/familypics.py
  [line 10], if this doesn't suit your needs)
