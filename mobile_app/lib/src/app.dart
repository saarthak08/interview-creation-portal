import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/theme.dart';
import 'package:interview_app/src/screens/home_screen.dart';
import 'package:interview_app/src/screens/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scaler Interview App",
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        '/home': (BuildContext context) => HomeScreen(),
      },
      home: SplashScreen(),
    );
  }
}
