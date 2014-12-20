library family_pics;

import 'package:angular/angular.dart';
import 'package:angular/animate/module.dart';
import 'package:angular/application_factory.dart';
import 'package:family_pics/component/navbar/navbar.dart';
import 'package:family_pics/component/picturegrid/picturegrid.dart';

String WEBSERVICE_URL = 'http://localhost/webservice';

class NavBar extends Module {
  NavBar() {
    bind(NavBarComponent);
  }
}

class PictureGrid extends Module {
  PictureGrid() {
    bind(PictureGridComponent);
  }
}

void main() {
  //ngBootstrap();
  var module = new Module()
    ..install(new AnimationModule());
  
  applicationFactory()
    .addModule(new NavBar())
    .addModule(new PictureGrid())
    .run();
}
