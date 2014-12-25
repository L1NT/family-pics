library photogrid_component;

import 'dart:async';
import 'package:angular/angular.dart';

@Component(
    selector: 'photogrid',
    templateUrl: 'photogrid.html',
    cssUrl: 'photogrid.css')
class PhotoGridComponent {
  List<Thumbnails> thumbnails = [];
  final Http _http;
  final String _webserviceUrl = 'http://localhost/webservice';

  String _path = '';
  void set path(String value) {
    _path = Uri.decodeQueryComponent(value);
    _loadThumbnails();
  }
  String get path => _path;
    
  PhotoGridComponent(this._http, RouteProvider routeProvider) {
//    new Timer.periodic(const Duration(seconds: 3), (timer) {
//      print(path.toString());
//    });
    path = routeProvider.parameters['path'];
  }
  
  void _loadThumbnails() {
    //ajax call to /webservice/familypics.py?function=get_directories&path=/
    _http.get(_webserviceUrl + '/familypics.py?function=get_thumbnails&path=/' + path)
      .then((HttpResponse response) {
        thumbnails = response.data;
      });
  }
  
  void getMedia(String url) {
    //fancybox me!
  }

}

class Thumbnails {
  String url;
  String item;
  String thumb;
  String error;
  
  Thumbnails(this.url, this.item, this.thumb, this.error);
}
