library photoalbum_routing;

import 'package:angular/angular.dart';

void photoAlbumRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'default-view': ngRoute(
      path: '/view/:path', //too bad this doesn't support "*" syntax, yet
      view: 'view/photogrid-view.html'
    )
  });
}
