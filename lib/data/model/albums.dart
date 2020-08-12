import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(userId: json['userId'], id: json['id'], title: json['title']);

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          userId == other.userId &&
          id == other.id &&
          title == other.title;
}

class AlbumList {
  final List<Album> albumList;

  AlbumList({this.albumList});

  factory AlbumList.fromRawJson(String str) =>
      AlbumList.fromJson(json.decode(str));

  factory AlbumList.fromJson(List<dynamic> json) => AlbumList(
      albumList: List<Album>.from(json.map((x) => Album.fromJson(x))));

  AlbumList sortList() {
    this.albumList.sort((a, b) {
      return (a.title.compareTo(b.title));
    });
    return this;
  }

  Album albumAtIndex(int index) {
    return this.albumList[index];
  }

  @override
  int get hashCode => albumList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumList && albumList == other.albumList;
}
