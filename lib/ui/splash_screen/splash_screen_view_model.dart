import 'package:rxdart/rxdart.dart';

class SplashScreenViewModel {
  final SplashViewModelInput input;
  SplashViewModelOutput output;

  SplashScreenViewModel(this.input) {
    Stream<bool> goToNext = input.onStart.flatMap((_) {
      return Stream.value(true).delay(Duration(seconds: 2));
    });

    output = SplashViewModelOutput(goToNext);
  }
}

class SplashViewModelInput {
  final Subject<bool> onStart;

  SplashViewModelInput(this.onStart);
}

class SplashViewModelOutput {
  final Stream<bool> onNextScreen;

  SplashViewModelOutput(this.onNextScreen);
}
