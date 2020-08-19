import 'package:albums/data/repo/deeplink_repo.dart';
import 'package:albums/ui/home_screen/app_tab_model.dart';
import 'package:albums/ui/home_screen/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockDeepLinkRepo extends Mock implements DeepLinkRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('test stream returns correct default values', () {
    DeepLinkResult deepLinkResult =
        DeepLinkResult(DeepLinkAction.openHome, value: null);
    final mockDeeplinkRepo = MockDeepLinkRepo();
    when(mockDeeplinkRepo.getDeepLinkResult()).thenAnswer(
      (_) => Stream.value(deepLinkResult),
    );
    final _viewModel = HomeViewModel(
      HomeViewModelInput(
        PublishSubject(),
        PublishSubject(),
      ),
      mockDeeplinkRepo,
    );
    List<AppTab> expectedList = [
      AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS),
      AppTab.fromType(NavBarItem.PROFILE),
    ];
    List<AppTab> expectedList2 = [
      AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS),
      AppTab.fromType(NavBarItem.PROFILE),
    ];
    expect(
      _viewModel.output.tabs,
      emitsInOrder(
        ([expectedList, expectedList2]),
      ),
    );
    _viewModel.input.onStart.add(true);
  });

  test('on profile tab selected', () async {
    DeepLinkResult deepLinkResult =
        DeepLinkResult(DeepLinkAction.openHome, value: null);
    final mockDeeplinkRepo = MockDeepLinkRepo();
    when(mockDeeplinkRepo.getDeepLinkResult()).thenAnswer(
      (_) => Stream.value(deepLinkResult),
    );
    final _viewModel = HomeViewModel(
      HomeViewModelInput(
        PublishSubject(),
        PublishSubject(),
      ),
      mockDeeplinkRepo,
    );
    List<AppTab> expectedList = [
      AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS),
      AppTab.fromType(NavBarItem.PROFILE),
    ];
    List<AppTab> expectedList2 = [
      AppTab.fromType(NavBarItem.BROWSE),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS, isSelected: true),
      AppTab.fromType(NavBarItem.PROFILE),
    ];
    expect(
      _viewModel.output.tabs,
      emitsInOrder([
        expectedList,
        expectedList2,
      ]),
    );
    _viewModel.input.onTap.add(AppTab.fromType(NavBarItem.NEWS));
  });

  test('on deeplink received tab selected', () async {
    Map<String, String> value = {'firstname': ' john'};
    DeepLinkResult deepLinkResult =
        DeepLinkResult(DeepLinkAction.openContactInfo, value: value);
    final mockDeeplinkRepo = MockDeepLinkRepo();
    when(mockDeeplinkRepo.getDeepLinkResult()).thenAnswer(
      (_) => Stream.value(deepLinkResult),
    );
    final _viewModel = HomeViewModel(
      HomeViewModelInput(
        PublishSubject(),
        PublishSubject(),
      ),
      mockDeeplinkRepo,
    );
    List<AppTab> expectedList = [
      AppTab.fromType(NavBarItem.BROWSE, isSelected: true),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS),
      AppTab.fromType(NavBarItem.PROFILE),
    ];
    List<AppTab> expectedList2 = [
      AppTab.fromType(NavBarItem.BROWSE),
      AppTab.fromType(NavBarItem.FRIENDS),
      AppTab.fromType(NavBarItem.NEWS),
      AppTab.fromType(
        NavBarItem.PROFILE,
        isSelected: true,
        deepLinkResult: deepLinkResult,
      ),
    ];
    expect(
      _viewModel.output.tabs,
      emitsInAnyOrder([
        expectedList,
        expectedList2,
      ]),
    );
    _viewModel.input.onStart.add(true);
  });
}
