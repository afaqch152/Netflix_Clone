import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../Components/ScreenBasicElements.dart';
import '../../Models/GameModel.dart';
import '../HomeScreen/EpisodeScreen/EpisodeScreenWidgets.dart';
import '../HomeScreen/HomePageWidgets.dart';

class GamesPageSliverAppbar extends SliverAppBar {
  GamesPageSliverAppbar({super.key, required super.backgroundColor})
      : super(
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
            Text(
              "Games",
              style: TextStyle(
                  color: Colors.white, fontSize: customFontSize(0.055)),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: customWidth(0.04)),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: customFontSize(0.07),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "Assets/Images/avatar.jpeg",
                    width: customWidth(0.08),
                    height: customWidth(0.08),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
          ],
        );
}

//Game Banner
class GameBanner extends Stack {
  GameBanner({super.key})
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
                    width: 60,
                    height: 60,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bannerButton(
                        text: "Get Game",
                        icon: Icons.download_rounded,
                        childColor: Colors.black,
                        bgColor: Colors.white,
                        onPressed: () {}),
                    bannerButton(
                        text: "Trailer",
                        icon: Icons.play_arrow_outlined,
                        childColor: Colors.white,
                        bgColor: Color.fromARGB(255, 126, 122, 122),
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          )
        ]);
}

//Scenes add
class ScenesAdd extends Container {
  ScenesAdd({super.key})
      : super(
          width: customWidth(),
          height: customHeight(0.48),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                  colors: [
                Color.fromRGBO(160, 49, 45, 1),
                Colors.black,
                Colors.black,
                Colors.black,
                Color.fromRGBO(160, 49, 45, 1)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "Assets/Images/popcorn.png",
                width: customFontSize(0.2),
                height: customFontSize(0.2),
              ),
              GradientText(
                "Create your Neftlix  \n    Game Handles.",
                style: TextStyle(
                    fontSize: customFontSize(0.07),
                    fontWeight: FontWeight.bold),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(218, 16, 1, 0.863),
                  Color.fromRGBO(220, 93, 152, 1),
                ]),
              ),
              Text(
                "You'll laugh.you'll swoon.You'll gasp.\n        You might even shed a tear.",
                style: TextStyle(
                    color: Colors.white, fontSize: customFontSize(0.04)),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStatePropertyAll(Size(customWidth(0.4), 50)),
                      maximumSize:
                          MaterialStatePropertyAll(Size(customWidth(0.49), 50)),
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: (() {}),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.person_pin_circle_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                      AutoSizeText(
                        "Watch Scenes",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: customFontSize(0.038),
                            color: Colors.black),
                      ),
                    ],
                  ))
            ],
          ),
        );
}

//Games video recomendation widget
class GameDetailsVideoWidget extends Column {
  int index;
  VideoPlayerController videoPlayerController;
  GameDetailsVideoWidget(
      {super.key, required this.index, required this.videoPlayerController})
      : super(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Video player showing games video
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: GameVideoPlayer(
                    videoPlayerController: videoPlayerController)),
            //Bottom showing games details
            Container(
                margin: EdgeInsets.only(
                  top: customHeight(0.008),
                  left: customHeight(0.008),
                ),
                width: customWidth(0.94),
                child: GameDetails(index: index))
          ],
        );
}

//Games video player
class GameVideoPlayer extends Container {
  VideoPlayerController videoPlayerController;
  GameVideoPlayer({super.key, required this.videoPlayerController})
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

//Game details widget
class GameDetails extends Row {
  int index;
  GameDetails({super.key, required this.index})
      : super(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                listGames[index].imgPath,
                width: customWidth(0.18),
                height: customHeight(0.09),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listGames[index].name,
                    style: TextStyle(
                        fontSize: customFontSize(0.035),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      listGames[index].category,
                      style: TextStyle(
                          fontSize: customFontSize(0.03),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  )
                ],
              ),
            )
          ],
        );
}

//Games data
List<GameModel> listGames = [
  GameModel(
      imgPath: "Assets/Images/seasons/Cardsblast.jpg",
      name: "Card Blast",
      category: "Card"),
  GameModel(
      imgPath: "Assets/Images/seasons/Shootinhoops.jpg",
      name: "Shooting Hoops",
      category: "Arcade"),
  GameModel(
      imgPath: "Assets/Images/seasons/Kentuckyroutezero.jpg",
      name: "Kentucky Route Zero",
      category: "Adventure"),
  GameModel(
      imgPath: "Assets/Images/seasons/Dragonup.jpg",
      name: "Dragon Up",
      category: "Adventure")
];
