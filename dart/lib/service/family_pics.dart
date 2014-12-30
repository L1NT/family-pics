library family_pics_service;

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:family_pics/model/directory.dart';
import 'package:family_pics/model/thumbnail.dart';


@Injectable()
class FamilyPicsService {
  final Http _http;
  final String _webserviceUrl = 'http://localhost/webservice';

  FamilyPicsService(this._http);

  Future getDirectories(String path) {
    return _http.get(_webserviceUrl + '/familypics.py?function=get_directories&path=/' + (path))
      .then((HttpResponse response) {
        List<Directory> directories = [];
        (response.data as List<String>).forEach((dir) {
          directories.add(new Directory(dir, path + '/' + dir));
        });
        return directories;
      });
  }

  Future getThumbnails(String path) {
    return _http.get(_webserviceUrl + '/familypics.py?function=get_thumbnails&path=' + path)
      .then((HttpResponse response) {
        return response.data as List<Thumbnail>;
      });
  }
}