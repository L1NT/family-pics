library family_pics;

import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:angular/animate/module.dart';
import 'package:angular/application_factory.dart';

import 'package:family_pics/component/navbar/navbar.dart';
import 'package:family_pics/component/photogrid/photogrid.dart';
import 'package:family_pics/formatter/url_encoder.dart';
import 'package:family_pics/routing/photoalbum_router.dart';
import 'package:family_pics/service/family_pics.dart';

//App configuration
const String WEBSERVICE_URL = 'http://localhost/webservice';
const String TITLE = 'Jeter Family Digital Photo Album';


class FamPics extends Module {
  FamPics() {
    bind(NavBarComponent);
    bind(PhotoGridComponent);

    bind(UrlEncoder);
    bind(FamilyPicsService);

    bind(RouteInitializerFn, toValue: photoAlbumRouteInitializer);
//this captures changes to the hash, instead of the default behavior of using both the path _and_ query parts of the URL
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
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
