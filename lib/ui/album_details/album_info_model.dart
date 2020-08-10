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
  get hashCode => albumName.hashCode ^ albumId.hashCode ^ photosCount.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumInfo &&
          albumName == other.albumName &&
          albumId == other.albumId &&
          photosCount == other.photosCount;
}
