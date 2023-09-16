import 'package:flutter/material.dart';

import 'package:netflix/Components/ScreenBasicElements.dart';

import 'package:video_player/video_player.dart';

import 'NewsPageWidgets.dart';

class NewsScreen extends StatelessWidget {
  static GlobalKey<NavigatorState> newsNavigtorKey =
      GlobalKey<NavigatorState>();
  static const pageName = "/NewsScreen";
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await NewsScreen.newsNavigtorKey.currentState!.maybePop(),
      child: Navigator(
        key: newsNavigtorKey,
        initialRoute: NewsPage.pageName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

class NewsPage extends StatefulWidget {
  static const pageName = "/NewsPage";
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
          SliverLayoutBuilder(builder: (BuildContext context, constraints) {
            //to hide the flexible app bar when scrolleed to some extent
            bool scrolled = constraints.scrollOffset > 25;
            return NewsSliverAppbar(
              backgroundColor: Color.fromRGBO(12, 10, 10, 0.8),
              isScrolling: scrolled,
            );
          }),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(customWidth(0.03)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Top heading
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.red,
                        size: customFontSize(0.06),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "Coming Soon",
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: customFontSize(0.05)),
                        ),
                      ),
                    ],
                  ),
                  //Main area
                  Container(
                    margin: EdgeInsets.only(
                        top: customHeight(0.025), bottom: customHeight(0.025)),
                    //Coming soon banner
                    child: ComingSoonBanner(
                        videoPlayerController: videoController),
                  )
                ],
              ),
            ),
          ),
          //Everyone's Watching banner
          SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.all(customWidth(0.03)),
                child: EveryOneWatchingBanner(
                  videoPlayerController: videoController,
                )),
          ),
        ],
      ),
    );
  }
}
