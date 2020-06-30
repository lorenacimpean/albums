import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHome extends Mock implements HomeViewModel {}

main() {
  test('test stream returns correct default values', () async {
    final viewModel = HomeViewModel();
    expect(
        viewModel.tabs,
        emits(NavBarTabs([
          AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
          AppTab.fromType(NavBarItem.FRIENDS),
          AppTab.fromType(NavBarItem.NEWS),
          AppTab.fromType(NavBarItem.PROFILE),
        ])));
  });

  test('on profile tab selected', () async {
    final viewModel = HomeViewModel();
    expect(
        viewModel.tabs,
        emitsInOrder([
          NavBarTabs([
            AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
            AppTab.fromType(NavBarItem.FRIENDS),
            AppTab.fromType(NavBarItem.NEWS),
            AppTab.fromType(NavBarItem.PROFILE),
          ]),
          NavBarTabs([
            AppTab.fromType(NavBarItem.BROWSE),
            AppTab.fromType(NavBarItem.FRIENDS),
            AppTab.fromType(NavBarItem.NEWS, isSelected: true),
            AppTab.fromType(NavBarItem.PROFILE),
          ])
        ]));
    viewModel.onTabSelected(AppTab.fromType(NavBarItem.NEWS));
  });
}
