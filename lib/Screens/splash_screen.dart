import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:flutter/material.dart';

import 'wrapper.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.width*0.5,
      splash: logo,
      nextScreen: const Wrapper(),
    );
  }
}
