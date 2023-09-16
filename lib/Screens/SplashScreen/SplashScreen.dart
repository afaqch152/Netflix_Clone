import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/Screens/HomeScreen/HomePage.dart';
import 'package:netflix/main.dart';

class SplashScreen extends StatefulWidget {
  static const pageName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double margin = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        margin = 1;
        timer.cancel();
      });
    });
    Timer.periodic(Duration(milliseconds: 2500), (timer) {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
        timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        child: Stack(children: [
          Image.asset(
            "Assets/Images/netflix.png",
            width: customWidth(),
            height: customHeight(0.4),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1500),
            margin: EdgeInsets.only(left: customWidth(margin)),
            width: customWidth(),
            height: customHeight(0.4),
            color: Colors.black,
          )
        ]),
      )),
    );
  }
}
 // AnimatedContainer(
            //   duration: Duration(seconds: 2),
            //   width: customWidth(width),
            //   height: customHeight(),
            //   color: Colors.black,
            // )