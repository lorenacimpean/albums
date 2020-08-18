import 'package:albums/data/repo/repo_factory.dart';
import 'package:albums/ui/home_screen/app_tab_model.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockHome extends Mock implements HomeViewModel {}

main() {
  final _viewModel = HomeViewModel(
    HomeViewModelInput(
      PublishSubject(),
      PublishSubject(),
    ),
    buildDeepLinkRepo(),
  );
  test('test stream returns correct default values', () async {
    expect(
        _viewModel.output.tabs,
        emits(([
          AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
          AppTab.fromType(NavBarItem.FRIENDS),
          AppTab.fromType(NavBarItem.NEWS),
          AppTab.fromType(NavBarItem.PROFILE),
        ])));
    _viewModel.input.onStart.add(true);
  });

  test('on profile tab selected', () async {
    expect(
      _viewModel.output.tabs,
      emits([
        AppTab.fromType(NavBarItem.BROWSE),
        AppTab.fromType(NavBarItem.FRIENDS),
        AppTab.fromType(NavBarItem.NEWS, isSelected: true),
        AppTab.fromType(NavBarItem.PROFILE),
      ]),
    );
    _viewModel.input.onTap.add(AppTab.fromType(NavBarItem.NEWS));
  });
}
