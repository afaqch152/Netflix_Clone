import 'package:flutter/material.dart';

import 'package:netflix/Screens/GamesScreen/Game%20Details%20Page/GameDetail.dart';
import 'package:netflix/Screens/GamesScreen/GamesPage.dart';
import 'package:netflix/Screens/HomeScreen/EpisodeScreen/EpisodeScreen.dart';
import 'package:netflix/Screens/HomeScreen/HomePage.dart';

import 'package:netflix/Screens/NewsScreen/NewsPage.dart';
import 'package:netflix/Screens/SplashScreen/SplashScreen.dart';
import 'package:netflix/main.dart';

//Made all the screen variables in isolation so it will be use anywhere
late Size size;
late double screenWidth, screenHeight, fontSize, topBarSize, bottomBarSize;
Color defaulColor = const Color.fromRGBO(23, 28, 38, 1),
    greyColor = Color.fromARGB(255, 99, 93, 93);

double customWidth([double size = 1]) {
  return screenWidth * size;
}

double customHeight([double size = 1]) {
  return screenHeight * size;
}

double customFontSize([double size = 0.05]) {
  return fontSize * size;
}
//To initialize the mediaquery elemens

void initialize(BuildContext context) {
  size = MediaQuery.of(context).size;

  screenWidth = size.width;
  topBarSize = MediaQuery.of(context).padding.top;
  bottomBarSize = MediaQuery.of(context).padding.bottom;
  screenHeight = size.height - bottomBarSize;

  fontSize = (screenWidth * 0.25 + screenHeight) / 2;
}
//Global on genereate route method for all the screens

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == EpisodeScreen.pageName) {
    return MaterialPageRoute(
        builder: ((context) => EpisodeScreen(
              color: Colors.amber,
            )));
  } else if (settings.name == GameDetail.pageName) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) {
      return GameDetail();
    }));
  } else if (settings.name == MainScreen.pageName) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) {
      return MainScreen();
    }));
  } else if (settings.name == GamesPage.pageName) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) {
      return GamesPage();
    }));
  } else if (settings.name == SplashScreen.pageName) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) {
      return SplashScreen();
    }));
  } else if (settings.name == NewsPage.pageName) {
    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) {
      return NewsPage();
    }));
  } else {
    return MaterialPageRoute(
        builder: (context) => MyHomePage(title: "MyHomePage"));
  }
}
