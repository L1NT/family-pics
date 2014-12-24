library photoalbum_component;

import 'package:angular/angular.dart';
//maybe needed for the animation? http://stackoverflow.com/questions/22569102/how-to-make-animation-in-angular-dart-please-tell-me
//import 'package:angular/animate/module.dart';

@Component(
    selector: 'photoalbum',
    templateUrl: 'photoalbum.html',
    cssUrl: 'photoalbum.css')
class PhotoAlbumComponent {
  List<Thumbnails> thumbnails = [];
  final Http _http;
  final String _webserviceUrl = 'http://localhost/webservice';

  String _path = '';
  void set path(value) {
    _path = value;
    _loadThumbnails();
  }
  String get path => _path;
    
  PhotoAlbumComponent(this._http);
  
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
