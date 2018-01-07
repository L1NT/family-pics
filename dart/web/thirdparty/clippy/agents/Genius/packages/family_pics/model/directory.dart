library directory_model;

class Directory {
  final String name;
  final String path;

  //prefix added to avoid invalid starting characters on id properties
  String get id => "subdir-" + name.replaceAll(' ', '');

  Directory(this.name, this.path);
}
