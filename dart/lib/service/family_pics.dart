library family_pics_service;

import 'dart:async';

import 'package:angular/angular.dart';

@Injectable()
class FamilyPicsService {

  final String _url = WEBSERVICE_URL;
  final Http _http;

  FamilyPicsService(this._http);

  Future getDirectories(String path) {

  }

  Future getThumbnails(String path) {

  }
}