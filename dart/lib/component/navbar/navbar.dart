library navbar_component;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:family_pics/model/directory.dart';
import 'package:family_pics/service/family_pics.dart';
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

  final FamilyPicsService _famPicService;
  final Animate animate = new Animate();

  NavBarComponent(this._famPicService) {
    _loadDirectories();
  }

  void _loadDirectories() {
    _famPicService.getDirectories(currentPath.length == 0 ? '' : currentPath.last.path)
      .then((List<Directory> values) {
        subDirectories = values;
        leftoffset = 0;
      })
      .catchError((e) {
        subDirectories.clear();
      });
  }

//  @NgCallback('ng-added')
//  void NgAdded(boolean last) {
//    print('ngadded called');
//    if (last) {
//      leftoffset = 0;
//    }
//  }

  void selectSubDirectory(dir) {
    var target = querySelector('navbar /deep/ #subdirectories li#'+dir.id);
    var notSelected = querySelectorAll('navbar /deep/ #subdirectories li');
    querySelector('navbar /deep/ #clickSound').play();
    animate.addClass(target, 'fadeOutLeft');
    for (Element item in notSelected) {
      animate.addClass(item, 'fadeOutRight');
    }
    currentPath.add(dir);
    _loadDirectories();
  }

  void selectCurrentDirectory(dir) {
    querySelector('navbar /deep/ #clickSound').play();
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

  //TODO: remove this once a ng-repeat listener is in place
  boolean get showRightArrow {
    var viewport = querySelector('navbar /deep/ #viewport');
    var scrollwidth = querySelector('navbar /deep/ #subdirectories');
//    print(viewport.toString());
//    print(scrollwidth.toString());
//    print(viewport != null && scrollwidth != null);

    if (viewport != null && scrollwidth != null) {
      maxoffset = viewport.clientWidth - scrollwidth.scrollWidth;
    }
//    print("leftoffset: " + leftoffset.toString() + "; maxoffset: " + maxoffset.toString());
//    print("difference: " + (maxoffset!=leftoffset).toString());
    return maxoffset != leftoffset;
  }
}
