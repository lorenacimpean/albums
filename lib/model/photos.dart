import 'dart:convert';

class Photo {
  final String albumId;
  final String id;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
      albumId: json['userId'],
      id: json['id'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl']);

  Map<String, dynamic> toJson() =>
      {"albumId": albumId, "id": id, "url": url, "thumbnailUrl": thumbnailUrl};
}

class PhotoList {
  final List<Photo> photos;

  PhotoList({this.photos});

  factory PhotoList.fromRawJson(String str) => json.decode(str);

  factory PhotoList.fromJson(Map<String, dynamic> json) => PhotoList(
      photos: List<Photo>.from(json["albums"].map((a) => Photo.fromJson(a))));

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((a) => a.toJson())),
      };
}
