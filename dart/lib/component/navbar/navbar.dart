library navbar_component;

import 'dart:html';
import 'package:angular/angular.dart';
//maybe needed for the animation? http://stackoverflow.com/questions/22569102/how-to-make-animation-in-angular-dart-please-tell-me
//import 'package:angular/animate/module.dart';

@Component(
    selector: 'navbar',
    templateUrl: 'navbar.html',
    cssUrl: 'navbar.css',
    publishAs: 'menu')
class NavBarComponent {
  List<Directory> currentPath = [];
  List<Directory> subDirectories = [];
  int maxoffset = 0;
  int _leftoffset = 0;

  final Http _http;  
  final String _webserviceUrl = 'http://localhost/webservice';
  final Animate animate = new Animate();

  NavBarComponent(this._http) {
    _loadDirectories();
  }
  
  void _loadDirectories() {
    _http.get(_webserviceUrl + '/familypics.py?function=get_directories&path=/' + (currentPath.length == 0 ? '' : currentPath.last.path))
      .then((HttpResponse response) {
        subDirectories = [];
        List<String> dirs = response.data;
        dirs.forEach((dir) {
          if (currentPath.length == 0) {
            subDirectories.add(new Directory(dir, dir));
          } else {
            subDirectories.add(new Directory(dir, currentPath.last.path + '/' + dir));
          }
        });
        return;
      });
  }

  void selectSubDirectory(dir) {
    var target = querySelector('navbar /deep/ #subdirectories li#'+dir.name);
    var notSelected = querySelectorAll('navbar /deep/ #subdirectories li');
    animate.addClass(target, 'fadeOutLeft');
    for (Element item in notSelected) {
      animate.addClass(item, 'fadeOutRight');
    }
    currentPath.add(dir);
    _loadDirectories();
  }
  
  void selectCurrentDirectory(dir) {
    int index = currentPath.indexOf(dir);
    animate.addClass(querySelector('navbar /deep/ ul#current'), 'fadeOutRight');
    currentPath.removeRange(index + 1, currentPath.length);
    _loadDirectories();
  }
  
  void subDirScroll(direction) {
    if (direction == 'left') {
      leftoffset += 300;
    } else if (direction == 'right') {
      leftoffset -= 300;
    }
  }
  
  void set leftoffset(int offset) {
    maxoffset = querySelector('navbar /deep/ #viewport').clientWidth - querySelector('navbar /deep/ #subdirectories').scrollWidth;
    if (offset < maxoffset) {
      _leftoffset = maxoffset;
    } else if (offset > 0) {
      _leftoffset = 0;
    } else {
      _leftoffset = offset;
    }
  }
  int get leftoffset => _leftoffset;

  String getEncoded(String s) => Uri.encodeQueryComponent(s);
}

class Directory {
  final String name;
  final String path;

  Directory(this.name, this.path);
}
