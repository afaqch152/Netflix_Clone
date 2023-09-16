import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:netflix/Components/ScreenBasicElements.dart';

import 'package:video_player/video_player.dart';

import '../HomeScreen/HomePageWidgets.dart';

import 'GamesScreenWidgets.dart';

class GamesScreen extends StatelessWidget {
  static GlobalKey<NavigatorState> gameNavigtorKey =
      GlobalKey<NavigatorState>();
  static const pageName = "/GamesScreen";
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await GamesScreen.gameNavigtorKey.currentState!.maybePop(),
      child: Navigator(
        key: gameNavigtorKey,
        initialRoute: GamesPage.pageName,
        onPopPage: ((route, result) => true),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

class GamesPage extends StatefulWidget {
  static const pageName = "/GamesPage";
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late VideoPlayerController videoController;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          GamesPageSliverAppbar(
              backgroundColor: const Color.fromRGBO(12, 10, 10, 0.6)),
          SliverToBoxAdapter(
            //Game banner top having two buttons
            child: GameBanner(),
          ),
          //Builder showing games recommendations
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
                    //Main heading of the games
                    child: SizedBox(
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
                //Inner games boxlist
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
                      return Padding(
                        padding: EdgeInsets.only(
                            top: customHeight(0.012),
                            left: customHeight(0.012),
                            bottom: customHeight(0.01)),
                        //Inner box of the list showing games
                        child: GameBox(
                            context: context,
                            index: index,
                            innerListIndex: innerIndex),
                      );
                    },
                  ),
                )
              ],
            ),
            childCount: 2,
          )),
          //Scenes Add
          SliverToBoxAdapter(child: ScenesAdd()),
          //Games videos recommendations
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: customHeight(0.025)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: customHeight(0.012),
                      right: customHeight(0.01),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        // height: customHeight(0.06),
                        child: Text(
                          "Mobile Games Trailors",
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: customFontSize(0.05),
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //Builder for showing game details with video
                  ListView.builder(
                    padding: EdgeInsets.only(top: customHeight(0.025)),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(
                            top: customHeight(0.005),
                            bottom: customHeight(0.02)),
                        //box of the builder for showing game
                        child: GameDetailsVideoWidget(
                            index: index,
                            videoPlayerController: videoController)),
                    itemCount: listGames.length,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
