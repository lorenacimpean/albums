import 'package:albums/ui/home_screen/home_screen.dart';
import 'package:albums/ui/splash_screen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  //animation duration
  SplashScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashScreenViewModel(
      SplashViewModelInput(
        PublishSubject(),
      ),
    );
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _viewModel.output.onNextScreen.listen((list) {
      setState(() {
        openNextScreen();
      });
    });
    _viewModel.input.onStart.add(true);
  }

  @override
  void dispose() {
    _viewModel.input.onStart.close();
    super.dispose();
  }

  openNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FadeTransition(
        opacity: _animation,
        //Center
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_icon.png'),
          ],
        ),
      ),
    );
  }
}
