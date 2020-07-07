import 'package:albums/themes/icons.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:albums/util/extensions.dart';
import 'package:test/test.dart';

void main() {
  test('tab not selected test ', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    AppTab selectedTab = tabList.getSelectedTab();
    expect(selectedTab, null);
  });

  test('tab selected test ', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    AppTab selectedTab = tabList.getSelectedTab();
    expect(selectedTab, mockTab);
  });

  test('selected tab index', () {
    AppTab mockTab =
        AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true);
    List<AppTab> tabList = List<AppTab>();
    tabList.add(mockTab);

    int index = tabList.getSelectedIndex();
    expect(index, 0);
  });

  test('compare lists false', () {
    List<AppTab> listA = List<AppTab>();
    listA.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, true));
    List<AppTab> listB = List<AppTab>();
    listB.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));

    expect(listA.compare(listB), false);
  });

  test('compare lists true', () {
    List<AppTab> listA = List<AppTab>();
    listA.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));
    List<AppTab> listB = List<AppTab>();
    listB.add(AppTab(NavBarItem.BROWSE, 'BROWSE', AppIcons.browseIcon, false));

    expect(listA.compare(listB), true);
  });
}
