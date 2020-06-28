import 'dart:async';

enum NavBarItem { BROWSE, FRIENDS, NEWS, PROFILE }

class HomeViewModel {

  NavBarItem defaultItem = NavBarItem.BROWSE;
  final StreamController<NavBarItem> _controller = StreamController<NavBarItem>.broadcast();
  int selectedTabIndex;
  Stream<NavBarItem> get stream => _controller.stream;


  void dispose() => _controller?.close();

  void onTabSelected(int i) {
    selectedTabIndex = i;
    switch (i) {
      case 0:
        _controller.sink.add(NavBarItem.BROWSE);
        break;
      case 1:
        _controller.sink.add(NavBarItem.FRIENDS);
        break;
      case 2:
        _controller.sink.add(NavBarItem.NEWS);
        break;
      case 3:
        _controller.sink.add(NavBarItem.PROFILE);
        break;
      default:
        _controller.sink.add(NavBarItem.BROWSE);
    }
  }
}
