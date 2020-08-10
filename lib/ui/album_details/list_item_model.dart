import 'package:albums/ui/album_details/album_details_view_model.dart';

class ListItem {
  final ListItemType type;
  final dynamic data;

  ListItem({
    this.type,
    this.data,
  });

  @override
  int get hashCode => type.hashCode ^ data.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItem && type == other.type && data == other.data;
}
