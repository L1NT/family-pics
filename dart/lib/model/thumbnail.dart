library thumbnail_model;

class Thumbnail {
  String url;
  String item;
  String media;
  String thumb;
  String error;

  Thumbnail(this.url, this.item, this.thumb, this.error) {
    RegExp movie = new RegExp(r'^\.(mov|3gp|mpg)', false, false);
    RegExp image = new RegExp(r'^\.(jpg|png|jpeg)', false, false);

    if (image.hasMatch(item))
      media = 'image';
    else if (movie.hasMatch(item))
      media = 'movie';
  }
}
