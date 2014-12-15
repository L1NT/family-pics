library family_pics;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:family_pics/component/navbar.dart';


class NavBar extends Module {
  NavBar() {
    bind(NavBarComponent);
  }
}

void main() {
  //ngBootstrap();
  applicationFactory()
    .addModule(new NavBar())
    .run();
}
