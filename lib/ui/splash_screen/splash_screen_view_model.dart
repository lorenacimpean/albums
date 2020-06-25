class SplashScreenViewModel {
  Future<bool> goToNext() async {
    return Future.delayed(Duration(seconds: 2), () => Future.value(true));
  }
}
