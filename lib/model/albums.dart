import 'dart:convert';

class Album {
  final String userId;
  final String id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(userId: json['userId'], id: json['id'], title: json['title']);

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};
}

class AlbumList {
  final List<Album> albums;

  AlbumList({this.albums});

  factory AlbumList.fromRawJson(String str) => json.decode(str);

  factory AlbumList.fromJson(Map<String, dynamic> json) => AlbumList(
      albums: List<Album>.from(json["albums"].map((a) => Album.fromJson(a))));

  Map<String, dynamic> toJson() => {
        "albums": List<dynamic>.from(albums.map((a) => a.toJson())),
      };
}
