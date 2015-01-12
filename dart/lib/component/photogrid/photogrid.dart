library photogrid_component;

import 'package:angular/angular.dart';
import 'package:family_pics/model/thumbnail.dart';
import 'package:family_pics/service/family_pics.dart';

@Component(
    selector: 'photogrid',
    templateUrl: 'photogrid.html',
    cssUrl: 'photogrid.css',
    useShadowDom: false)
class PhotoGridComponent {
  final FamilyPicsService _famPicService;
  List<Thumbnail> thumbnails = [];

  String _path = '';
  void set path(String value) {
    _path = Uri.decodeQueryComponent(value);
    _loadThumbnails();
  }
  String get path => _path;

  PhotoGridComponent(this._famPicService, RouteProvider routeProvider) {
    path = routeProvider.parameters['path'];
  }

  void _loadThumbnails() {
    _famPicService.getThumbnails(path)
      .then((List<Thumbnail> values) {
        thumbnails = values;
      })
      .catchError((e) {
        thumbnails.clear();
        print(e);
      });
  }

  void getMedia(String url) {
    //fancybox me!
  }

}
