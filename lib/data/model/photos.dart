import 'dart:convert';

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
      albumId: json['userId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl']);

  @override
  int get hashCode =>
      albumId.hashCode ^
      id.hashCode ^
      title.hashCode ^
      url.hashCode ^
      thumbnailUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          this.albumId == other.albumId &&
          this.id == other.id &&
          this.title == other.title &&
          this.url == other.url &&
          this.thumbnailUrl == other.thumbnailUrl;
}

class PhotoList {
  final List<Photo> photos;

  PhotoList({this.photos});

  factory PhotoList.fromRawJson(String str) =>
      PhotoList.fromJson(json.decode(str));

  factory PhotoList.fromJson(List<dynamic> json) =>
      PhotoList(photos: List<Photo>.from(json.map((a) => Photo.fromJson(a))));

  int photosCount() {
    return this?.photos?.length ?? 0;
  }

  int selectedIndex(Photo selectedPhoto) {
    return this.photos?.indexWhere((photo) => photo == selectedPhoto);
  }

  @override
  int get hashCode => photos.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoList && this.photos == other.photos;
}
