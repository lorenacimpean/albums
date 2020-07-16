import 'package:albums/ui/home_screen/home_view_model.dart';

extension ListExtensions<T> on List<T> {
  int get hash => this.fold(
      1, (previousValue, element) => previousValue.hashCode ^ element.hashCode);

  bool compare(List<T> other) {
    if (length != other.length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}

extension SelectedItems on List<AppTab> {
  int getSelectedIndex() {
    AppTab selectedTab = this.getSelectedTab();
    int index = indexOf(selectedTab);
    return index;
  }

  AppTab getSelectedTab() {
    AppTab selectedTab =
        this?.firstWhere((tab) => tab.isSelected, orElse: () => null);
    return selectedTab;
  }
}
extension FirstLetter on String{
  String firstLetterToUpperCase(){
    String text = this?.substring(0,1)?.toUpperCase();
    return text;
  }
}
