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
}

class PhotoList {
  final List<Photo> photos;

  PhotoList({this.photos});

  factory PhotoList.fromRawJson(String str) =>
      PhotoList.fromJson(json.decode(str));

  factory PhotoList.fromJson(List<dynamic> json) =>
      PhotoList(photos: List<Photo>.from(json.map((a) => Photo.fromJson(a))));
}
