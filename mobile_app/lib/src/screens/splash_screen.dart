import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/src/helper/dimensions.dart';
import 'package:interview_app/src/screens/home_screen.dart';
import 'package:interview_app/src/widgets/scale_page_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String token = "";
  String email = "";
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));

    Timer(Duration(seconds: 3), () {
      _controller.stop();
      Navigator.pushReplacement(context, ScalePageRoute(page: HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(children: <Widget>[
            SlideTransition(
                position: _offsetAnimation,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: "ico",
                      child: Container(
                        height: getDeviceHeight(context) * 0.60,
                        width: getDeviceWidth(context) * 0.60,
                        child: Image.asset('assets/img/icon.png'),
                      ),
                    ))),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: getViewportHeight(context) * 0.6),
                child: Column(
                  children: <Widget>[
                    Text(
                      'ICP',
                      style: TextStyle(
                          color: Color(0xff00008b),
                          fontSize: getDeviceHeight(context) * 0.06,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getDeviceHeight(context) * 0.05),
                    Text(
                      '"Interview Creation Portal"',
                      style: TextStyle(
                          fontFamily: "Pacifico",
                          color: Colors.blue,
                          fontSize: getDeviceHeight(context) * 0.03),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getDeviceHeight(context) * 0.05),
                    Text(
                      'Built By Saarthak Gupta',
                      style: TextStyle(
                          fontFamily: "Mulish",
                          color: Colors.blue,
                          fontSize: getDeviceHeight(context) * 0.02),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
