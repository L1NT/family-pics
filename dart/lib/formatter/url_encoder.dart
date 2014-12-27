library url_encoder;

import 'package:angular/angular.dart';

@Formatter(name: 'urlencoder')
class UrlEncoder {
  String call(String s) => Uri.encodeQueryComponent(s);
}