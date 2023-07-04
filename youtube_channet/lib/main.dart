import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'HOme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Column(
        children: const [
          Image(image: AssetImage('images/logo.png'),),

        ],
      )
      , nextScreen:Home(),
      splashIconSize:400,
      duration: 1500,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration( seconds: 1),
    );

  }
}