import 'package:albums/data/model/photos.dart';

class GalleryDetails {
  final PhotoList photoList;
  final int selectedIndex;

  GalleryDetails({
    this.photoList,
    this.selectedIndex,
  });

  @override
  get hashCode => photoList.hashCode ^ selectedIndex.hashCode;

  @override
  bool operator ==(other) {
    identical(this, other) ||
        other is GalleryDetails &&
            this.photoList == other.photoList &&
            this.selectedIndex == other.selectedIndex;
  }
}
