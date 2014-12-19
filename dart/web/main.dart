library family_pics;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:family_pics/component/navbar/navbar.dart';
import 'package:family_pics/component/picturegrid/picturegrid.dart';


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
  applicationFactory()
    .addModule(new NavBar())
    .addModule(new PictureGrid())
    .run();
}
