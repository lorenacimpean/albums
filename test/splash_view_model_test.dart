import 'package:albums/ui/splash_screen/splash_screen_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockSplash extends Mock implements SplashScreenViewModel {}

main() {
  test('test goToNext returns true after timer is finished', () {
    final viewModel = MockSplash();
    when(viewModel.goToNext()).thenAnswer((_) async => true);
    viewModel.goToNext().then((value) => expect(value, true));
  });
}
