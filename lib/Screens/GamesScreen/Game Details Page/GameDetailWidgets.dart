import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

import '../../../Components/ScreenBasicElements.dart';
import '../../HomeScreen/EpisodeScreen/EpisodeScreenWidgets.dart';

class GamesDetailsSliverAppbar extends SliverAppBar {
  GamesDetailsSliverAppbar({
    super.key,
    required super.backgroundColor,
  }) : super(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          snap: true,
          title: GamesBarRow(),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              bottom: customHeight(0.015),
            ),
          ),
        );
}

//Innser row for Games screen top bar
class GamesBarRow extends Row {
  GamesBarRow({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: customWidth(0.04)),
                  child: InkWell(onTap: () {}, child: Spacer()),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "Assets/Images/avatar.jpeg",
                width: customWidth(0.08),
                height: customWidth(0.08),
                fit: BoxFit.fill,
              ),
            )
          ],
        );
}

//Games details banner
class GameDetailsBanner extends Stack {
  GameDetailsBanner({super.key})
      : super(alignment: Alignment.bottomCenter, children: [
          Image.asset(
            "Assets/Images/carsgame.gif",
            width: screenWidth,
            fit: BoxFit.fill,
            height: customHeight(0.6),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.transparent,
                  Color.fromRGBO(12, 10, 10, 1)
                ])),
            width: screenWidth,
            height: customHeight(0.6),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: customHeight(0.015)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: customHeight(0.02)),
                  child: Image.asset(
                    "Assets/Images/netflixicon.png",
                    width: customWidth(0.3),
                    height: customWidth(0.3),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: customHeight(0.02)),
                  child: AutoSizeText(
                    "Raji An ancient Epis",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.05)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    gamesDetailsBannerButton(
                        text: "Get Game",
                        icon: Icons.download_rounded,
                        childColor: Colors.black,
                        bgColor: Colors.white,
                        iconSize: customFontSize(0.05),
                        onPressed: () {}),
                    SizedBox(
                      width: customWidth(0.13),
                      height: customHeight(0.054),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: customWidth(0.13),
                            height: customHeight(0.03),
                            child: const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: customWidth(0.13),
                            height: customHeight(0.015),
                            child: const AutoSizeText(
                              "Share",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]);
}

//Games Details Banner button
Widget gamesDetailsBannerButton(
    {required String text,
    required IconData icon,
    required childColor,
    required Color bgColor,
    required double iconSize,
    required VoidCallback onPressed}) {
  return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
          fixedSize: MaterialStatePropertyAll(
              Size(customWidth(0.75), customHeight(0.054)))),
      onPressed: (() {}),
      child: Center(
        child: SizedBox(
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: childColor,
              fontWeight: FontWeight.bold,
              fontSize: customFontSize(0.036),
            ),
            maxLines: 1,
          ),
        ),
      ));
}

//Game banner description
class BannerDesc extends Column {
  String desc;
  String mode;
  BannerDesc({super.key, required this.desc, required this.mode})
      : super(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              desc,
              maxLines: 6,
              style: TextStyle(
                fontSize: customFontSize(0.032),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: customWidth(0.02)),
              child: AutoSizeText(
                "Modes:${mode}",
                maxLines: 1,
                style: TextStyle(
                  fontSize: customFontSize(0.032),
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
}

//Game details video
class GameDetailsVideo extends Container {
  VideoPlayerController videoPlayerController;
  GameDetailsVideo({super.key, required this.videoPlayerController})
      : super(
          width: customWidth(0.94),
          height: customHeight(0.24),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              //Simple video player
              VideoPlayer(videoPlayerController),
              //Controls
              ControlsOverlay(controller: videoPlayerController),
              //Bottom red line showing progress of video
              VideoProgressIndicator(videoPlayerController,
                  allowScrubbing: true)
            ],
          ),
        );
}
