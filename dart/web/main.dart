library family_pics;

import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:angular/animate/module.dart';
import 'package:angular/application_factory.dart';

import 'package:family_pics/component/navbar/navbar.dart';
import 'package:family_pics/component/photogrid/photogrid.dart';
import 'package:family_pics/routing/photoalbum_router.dart';

//App configuration
const String WEBSERVICE_URL = 'http://localhost/webservice';


class FamPics extends Module {
  FamPics() {
    bind(NavBarComponent);
    bind(PhotoGridComponent);
    bind(RouteInitializerFn, toValue: photoAlbumRouteInitializer);
  }
}

void main() {
  //ngBootstrap();
//  var module = new Module()
//    ..install(new AnimationModule());
  
  //debugging help:
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });

  applicationFactory()
    .addModule(new AnimationModule())
    .addModule(new FamPics())
    .run();
}
