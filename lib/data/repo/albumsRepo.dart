import 'package:albums/data/api/albums_client.dart';
import 'package:albums/data/api/remote_data_source.dart';
import 'package:albums/data/model/result.dart';
import 'package:flutter/material.dart';

class AlbumsRepo extends RemoteDataSource {

  RemoteDataSource _remoteDataSource;
  AlbumsRepo(this._remoteDataSource) : super(_remoteDataSource);

  Future<Result> getAlbums() {
    return _remoteDataSource.getAlbums();
  }
}
