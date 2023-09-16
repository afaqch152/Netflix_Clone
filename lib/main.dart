import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/Screens/DownloadScreen/DownloadPage.dart';
import 'package:netflix/Screens/GamesScreen/GamesPage.dart';
import 'package:netflix/Screens/HomeScreen/EpisodeScreen/EpisodeScreen.dart';
import 'package:netflix/Screens/SplashScreen/SplashScreen.dart';
import 'Components/BottomBar.dart';
import 'Screens/HomeScreen/HomePage.dart';
import 'Screens/NewsScreen/NewsPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        await Future.delayed(Duration(milliseconds: 500));
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return !await Navigator.of(context).maybePop();
      }),
      child: MaterialApp(
        title: 'Netflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashScreen.pageName,
      ),
    );
  }
}

int screenIndex = 0;

class MainScreen extends StatefulWidget {
  static const pageName = "/MainScreen";
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

bool isVp = false;

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    initialize(context);
    //Will pop scope checks whether there is widget on the stack when backbutton is presses if present
    //it pop the widget otherwise close the app
    return OrientationBuilder(
        builder: ((context, orientation) => Scaffold(
              //Stack storing the nav bar screens
              body: IndexedStack(
                index: screenIndex,
                children: const [
                  HomeScreen(),
                  GamesScreen(),
                  NewsScreen(),
                  DownloadPage(),
                ],
              ),
              bottomNavigationBar: BottomBar(
                onClick: (() {
                  setState(() {});
                }),
              ),
            )));
  }
}
