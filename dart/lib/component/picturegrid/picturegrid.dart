library picturegrid_component;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
//maybe needed for the animation? http://stackoverflow.com/questions/22569102/how-to-make-animation-in-angular-dart-please-tell-me
//import 'package:angular/animate/module.dart';

@Component(
    selector: 'picturegrid',
    templateUrl: 'picturegrid.html',
    cssUrl: 'picturegrid.css')
class PictureGridComponent {
  List<String> currentPath = [];
  List thumbnails = [];
  final Http _http;
  final String _webserviceUrl = 'http://localhost/webservice';

  PictureGridComponent(this._http) {
    _loadThumbnails();
  }

  void _loadThumbnails() {
    //ajax call to /webservice/familypics.py?function=get_directories&path=/
    _http.get(_webserviceUrl + '/familypics.py?function=get_thumbnails&path=/' + this.currentPath.join('/'))
      .then((HttpResponse response) {
        thumbnails = response.data;
      });
  }
  
}
