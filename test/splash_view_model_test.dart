import 'package:albums/ui/splash_screen/splash_screen_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class MockSplash extends Mock implements SplashScreenViewModel {}

main() {
  test('test goToNext returns true after timer is finished', () {
    final _viewModel = SplashScreenViewModel(
      SplashViewModelInput(
        BehaviorSubject(),
      ),
    );

    Stream<bool> actualResult = _viewModel.output.onNextScreen;
    expect(actualResult, emits(true));
    _viewModel.input.onStart.add(true);
    _viewModel.input.onStart.close();

  });
}
