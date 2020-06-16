import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(userId: json['userId'], id: json['id'], title: json['title']);

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};
}

class Gallery {
  final List<Album> albumList;

  Gallery({this.albumList});

  factory Gallery.fromRawJson(String str) => Gallery.fromJson(json.decode(str));

  factory Gallery.fromJson(List<dynamic> json) =>
      Gallery(albumList: List<Album>.from(json.map((x) => Album.fromJson(x))));
}
