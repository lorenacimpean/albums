import 'package:albums/data/model/albums.dart';
import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:flutter/foundation.dart';

class TapAction {
  final ActionType actionType;
  final Album album;
  final String toastMessage;

  TapAction({
    @required this.actionType,
    @required this.album,
    this.toastMessage,
  });

  @override
  get hashCode => actionType.hashCode ^ album.hashCode ^ toastMessage.hashCode;

  @override
  bool operator ==(other) {
    identical(this, other) ||
        other is TapAction &&
            this.actionType == other.actionType &&
            this.album == other.album &&
            this.toastMessage == other.toastMessage;
  }
}
