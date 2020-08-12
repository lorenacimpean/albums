class AlbumInfo {
  final String albumName;
  final int albumId;
  final int photosCount;

  AlbumInfo({
    this.albumName,
    this.albumId,
    this.photosCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumInfo &&
          runtimeType == other.runtimeType &&
          albumName == other.albumName &&
          albumId == other.albumId &&
          photosCount == other.photosCount;

  @override
  int get hashCode =>
      albumName.hashCode ^ albumId.hashCode ^ photosCount.hashCode;
}
