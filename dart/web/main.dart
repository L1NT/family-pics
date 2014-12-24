library family_pics;

import 'package:angular/angular.dart';
import 'package:angular/animate/module.dart';
import 'package:angular/application_factory.dart';
import 'package:family_pics/component/navbar/navbar.dart';
import 'package:family_pics/component/photoalbum/photoalbum.dart';

//App configuration
const String WEBSERVICE_URL = 'http://localhost/webservice';

//route glue between the componets
//List<String> currentPath = [];


class FamPics extends Module {
  FamPics() {
    bind(NavBarComponent);
    bind(PhotoAlbumComponent);
  }
}

void main() {
  //ngBootstrap();
//  var module = new Module()
//    ..install(new AnimationModule());
  
  applicationFactory()
    .addModule(new AnimationModule())
    .addModule(new FamPics())
    .run();
}
