library navbar_component;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
//maybe needed for the animation? http://stackoverflow.com/questions/22569102/how-to-make-animation-in-angular-dart-please-tell-me
//import 'package:angular/animate/module.dart';

@Component(
    selector: 'navbar',
    templateUrl: 'navbar.html',
    cssUrl: 'navbar.css')
class NavBarComponent {
  List<String> currentPath = [];
  List<String> directories;
  int maxoffset = -1;
  int _leftoffset = 0;
  final Http _http;
  
  NavBarComponent(this._http) {
    _loadDirectories();
  }
  
  void _loadDirectories() {
    //ajax call to /webservice/familypics.py?function=get_directories&path=/
    _http.get('/webservice/familypics.py?function=get_directories&path=/' + this.currentPath.join('/'))
      .then((HttpResponse response) {
        directories = response.data;
        leftoffset = 0;
      });
  }
  
  void selectSubDirectory(dir) {
    directories.remove(dir);
    currentPath.add(dir);
    _loadDirectories();
  }
  
  void selectCurrentDirectory(dir) {
    int index = currentPath.indexOf(dir);
    currentPath.removeRange(index + 1, currentPath.length);
    _loadDirectories();
  }
  
  void subDirScroll(direction) {
    if (direction == 'left') {
      leftoffset += 100;
    } else if (direction == 'right') {
      leftoffset -= 100;
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
  
}
