import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/Screens/GamesScreen/GamesPage.dart';

import 'package:video_player/video_player.dart';

import 'GameDetailWidgets.dart';

class GameDetail extends StatefulWidget {
  static const pageName = "/GamesDetail";

  @override
  State<GameDetail> createState() => _GamePageState();
}

class _GamePageState extends State<GameDetail> {
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
          GamesDetailsSliverAppbar(
              backgroundColor: Color.fromRGBO(12, 10, 10, 0.8)),
          //Banner showing game
          SliverToBoxAdapter(child: GameDetailsBanner()),
          //Banner details
          SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.all(customWidth(0.04)),
                child: BannerDesc(
                    desc:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    mode: "Single-Player")),
          ),
          //Crousel slider having game video and other details
          SliverToBoxAdapter(
            child: SizedBox(
              width: customWidth(),
              child: CarouselSlider(
                items: [
                  //video
                  Container(
                    margin: EdgeInsets.only(
                        left: customWidth(0.02), right: customWidth(0.02)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: GameDetailsVideo(
                          videoPlayerController: videoController,
                        )),
                  ),
                  //next widget in the slider
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset("Assets/Images/mirza.jpg")),
                ],
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  viewportFraction: 0.9,
                  initialPage: 0,
                ),
              ),
            ),
          ),

          //More details of the game in the list of options

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  top: customHeight(0.012),
                  left: customHeight(0.016),
                  right: customHeight(0.016),
                  bottom: customHeight(0.025)),
              height: customHeight(0.7),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      // height: customHeight(0.06),
                      child: Text(
                        "More Details",
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: customFontSize(0.05),
                            color: Colors.white),
                      ),
                    ),
                  ),

                  //LIst view showing multiple options
                  Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.only(top: 4),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return SizedBox(
                              height: customHeight(0.065),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                        fontSize: customFontSize(0.03),
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "Actions",
                                    style: TextStyle(
                                        fontSize: customFontSize(0.03),
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            );
                          }),
                          separatorBuilder: ((context, index) {
                            return Container(
                              height: 0.8,
                              color: Colors.grey,
                            );
                          }),
                          itemCount: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
