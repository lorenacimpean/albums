import 'package:albums/ui/album_details/album_details_view_model.dart';
import 'package:collection/collection.dart';

class ListItem {
  final ListItemType type;
  final dynamic data;

  ListItem({
    this.type,
    this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItem &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          data == other.data;

  @override
  int get hashCode => type.hashCode ^ data.hashCode;
}

class ListItems {
  final List<ListItem> listItems;

  ListItems(this.listItems);

  bool areListsEqual(List<ListItem> listA, List<ListItem> listB) {
    return ListEquality().equals(
      listA,
      listB,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItems &&
          runtimeType == other.runtimeType &&
          areListsEqual(listItems, other.listItems);

  @override
  int get hashCode => listItems.hashCode;
}
