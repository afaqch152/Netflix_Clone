import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:netflix/Screens/HomeScreen/HomePageWidgets.dart';
import 'package:netflix/Screens/HomeScreen/VideoPlayerScreen.dart/VideoPlayer.dart';
import 'package:video_player/video_player.dart';

import '../../Components/ScreenBasicElements.dart';

class HomeScreen extends StatelessWidget {
  static GlobalKey<NavigatorState> navigtorKey = GlobalKey<NavigatorState>();
  static bool canPop = false;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return !await HomeScreen.navigtorKey.currentState!.maybePop();
      }),
      child: Navigator(
        key: navigtorKey,
        onPopPage: ((route, result) => true),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const pageName = "/MyHomePage";
  late VideoPlayerController _videoController;
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController videoController;
  Color bgColor = const Color.fromRGBO(61, 38, 44, 1);
  Color hoverColor = Colors.transparent;
  late MyVideoPlayer videoPlayerScreen;
  int recRandom = 0;
  @override
  void initState() {
    super.initState();

    //initializing video
    videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    recRandom = Random().nextInt(1);
    initialize(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(slivers: [
          //Sliver app bar showing search and profile icon

          SliverLayoutBuilder(
            builder: (BuildContext context, constraints) {
              //to change the color of app bar when scrolleed to some extent
              bool scrolled = constraints.scrollOffset > 80;

              return HomeSliverAppbar(
                backgroundColor: scrolled
                    ? const Color.fromRGBO(14, 11, 12, 0.5)
                    : listRecommendation[recRandom].bgColor,
              );
            },
          ),

          SliverToBoxAdapter(
            child: UnconstrainedBox(
              //Big box showing recommendation
              child: Container(
                margin: EdgeInsets.only(bottom: customHeight(0.01)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      listRecommendation[recRandom].bgColor,
                      listRecommendation[recRandom].bgColor,
                      listRecommendation[recRandom].bgColor,
                      Colors.black
                    ])),
                width: customWidth(),
                child:
                    Align(child: BigRecommendationBanner(recRandom: recRandom)),
              ),
            ),
          ),
//Multiple seasons showing with seperate design for videos,only simple seasons,top 10 movies using builder
//One vertical builder and init multiple horizontal builders
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: customHeight(0.012),
                      right: customHeight(0.01),
                      top: customHeight(0.005)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      //Main title for seasons horizontal list
                      child: Text(
                        seasonsList[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: customFontSize(0.05),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                //Inner builder showing horizontal list with multiple designs
                SizedBox(
                  height: customHeight(0.25),
                  width: customWidth(),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    itemCount: seasonsList[index].seasons.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, innerIndex) {
                      return (index == 2)
                          //Games box
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: customHeight(0.012),
                                  left: customHeight(0.012),
                                  bottom: customHeight(0.01)),
                              child: GameBox(
                                  context: context,
                                  index: index,
                                  innerListIndex: innerIndex))
                          //WIth video
                          : (index == 1)
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: customHeight(0.012),
                                      left: customHeight(0.012),
                                      bottom: customHeight(0.0)),
                                  child: videoBox(
                                      context: context,
                                      index: index,
                                      innerListIndex: innerIndex,
                                      videoPlayerController: videoController))
                              //Numbering
                              : (index == 5 || index == 7)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: customHeight(0.012),
                                          left: customHeight(0.012)),
                                      child: NumberingBox(
                                          context: context,
                                          index: index,
                                          innerListIndex: innerIndex))
                                  //Simple box which will be shown most of the times

                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: customHeight(0.012),
                                          left: customHeight(0.012)),
                                      child: SimpelBox(
                                          context: context,
                                          index: index,
                                          innerListIndex: innerIndex));
                    },
                  ),
                )
              ],
            ),
            childCount: seasonsList.length,
          )),

          //Scenes Add at the bottom
          SliverToBoxAdapter(child: PopCornAdd())
        ]));
  }
}
