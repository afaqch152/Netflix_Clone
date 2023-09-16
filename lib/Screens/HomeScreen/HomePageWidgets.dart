import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:video_player/video_player.dart';

import '../../Models/SeasonsRecommendationModel.dart';
import '../GamesScreen/Game Details Page/GameDetail.dart';
import 'EpisodeScreen/EpisodeScreen.dart';
import 'HomePage.dart';
import 'VideoPlayerScreen.dart/VideoPlayer.dart';

//HOmePageSliverappbar
class HomeSliverAppbar extends SliverAppBar {
  HomeSliverAppbar({super.key, required super.backgroundColor})
      : super(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          expandedHeight: kToolbarHeight * 2.1,
          snap: true,
          title: InnerSearchRow(),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              bottom: customHeight(0.015),
            ),
            background: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: customHeight(0.03)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.scale(
                        scale: 1.6, child: NavButton(text: "TV Shows")),
                    Transform.scale(
                        scale: 1.6, child: NavButton(text: "Movies")),
                    Transform.scale(
                      scale: 1.6,
                      child: NavButton(
                        text: "Categories",
                        rightPadding: 0.01,
                        icon: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
}

//Inner row for serach bar
class InnerSearchRow extends Row {
  InnerSearchRow({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              width: customWidth(0.77),
              height: kToolbarHeight * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: customWidth(0.045)),
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 104, 101, 101),
                      size: customFontSize(0.055),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: customWidth(0.025)),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 116, 116),
                          fontSize: customFontSize(0.038),
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
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
            )
          ],
        );
}

//Navigation button widget
class NavButton extends Container {
  final String text;
  final bool icon;
  final double rightPadding;
  NavButton(
      {super.key,
      required this.text,
      this.icon = false,
      this.rightPadding = 0.03})
      : super(
          height: kToolbarHeight * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: customWidth(0.03), right: customWidth(rightPadding)),
              child: Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: customFontSize(0.019)),
                  ),
                  icon
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: customFontSize(0.03),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        );
}

//Center big banner widget showing recomendation
class BigRecommendationBanner extends Stack {
  int recRandom;
  BigRecommendationBanner({super.key, required this.recRandom})
      : super(alignment: Alignment.bottomCenter, children: [
          RecommendationBannerMainArea(
              bgColor: listRecommendation[recRandom].bgColor,
              secondaryColor: listRecommendation[recRandom].bottomColor,
              imgPath: listRecommendation[recRandom].imgPath),
          //Bottom buttons

          Padding(
            padding: EdgeInsets.only(
                bottom: customHeight(0.022),
                left: customWidth(0.05),
                right: customWidth(0.05)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                bannerButton(
                    text: "Play",
                    icon: Icons.play_arrow,
                    childColor: Colors.black,
                    bgColor: const Color.fromRGBO(255, 255, 255, 1),
                    onPressed: (() async {})),
                bannerButton(
                    text: "My List",
                    icon: Icons.add,
                    childColor: Colors.white,
                    bgColor: listRecommendation[recRandom].bgColor,
                    onPressed: (() {}))
              ],
            ),
          ),
        ]);
}

//Recommendatin banner top area only banner
class RecommendationBannerMainArea extends Container {
  final Color bgColor;
  final Color secondaryColor;
  final String imgPath;
  //Main container having color same as of image  which contains another container and bottom buttons
  RecommendationBannerMainArea(
      {super.key,
      required this.secondaryColor,
      required this.imgPath,
      required this.bgColor})
      : super(
          margin: EdgeInsets.only(bottom: customHeight(0.01)),
          width: customWidth(0.85),
          height: customHeight(0.62),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: secondaryColor),
              color: secondaryColor,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                //Inner container which contains image
                child: Container(
                  width: customWidth(0.85),
                  height: customHeight(0.54),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                        image: AssetImage(
                          imgPath,
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18))),
                ),
              ),
            ],
          ),
        );
}

//Banner button
Widget bannerButton({
  required String text,
  required IconData icon,
  required childColor,
  required Color bgColor,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
          fixedSize: MaterialStatePropertyAll(
              Size(customWidth(0.36), customHeight(0.052)))),
      onPressed: (() {}),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: customWidth(0.01)),
            child: Icon(
              icon,
              color: childColor,
              size: customFontSize(0.05),
            ),
          ),
          Text(
            text,
            style:
                TextStyle(color: childColor, fontSize: customFontSize(0.036)),
          )
        ],
      ));
}

//Game box
class GameBox extends Column {
  BuildContext context;
  int index, innerListIndex;
  GameBox(
      {super.key,
      required this.context,
      required this.index,
      required this.innerListIndex})
      : super(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => GameDetail())));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    seasonsList[index].seasons[innerListIndex].imgPath,
                    width: customWidth(0.29),
                    height: customHeight(0.155),
                    //0.235
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              width: customWidth(0.29),
              child: Padding(
                padding: EdgeInsets.only(
                  left: customWidth(0.008),
                  // right: customWidth(0.008),
                  // top: customWidth(0.006),
                  // bottom: customWidth(0.008),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        seasonsList[index].seasons[innerListIndex].name,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: customFontSize(0.03),
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        "Simulation",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: customFontSize(0.03),
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
}

//Simple box
class SimpelBox extends Column {
  BuildContext context;
  int index, innerListIndex;
  SimpelBox(
      {super.key,
      required this.context,
      required this.index,
      required this.innerListIndex})
      : super(
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: ((context) => EpisodeScreen(
                //           color: Colors.amber,
                //         ))));
                Navigator.of(context).pushNamed(EpisodeScreen.pageName);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    seasonsList[index].seasons[innerListIndex].imgPath,

                    width: customWidth(0.29),
                    height: customHeight(0.19),
                    //0.235
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        );
}

//Video box for showing the seasons already watch but not complete
class videoBox extends Column {
  BuildContext context;
  int index, innerListIndex;
  VideoPlayerController videoPlayerController;
  videoBox(
      {super.key,
      required this.context,
      required this.index,
      required this.innerListIndex,
      required this.videoPlayerController})
      : super(
          children: [
            InkWell(
              onTap: (() async {
                //delay so it smoothly plays
                await Future.delayed(const Duration(milliseconds: 500));
                Navigator.of(context, rootNavigator: true).push(
                    PageRouteBuilder(
                        pageBuilder: ((context, animation, secondaryAnimation) {
                  return Material(
                    child:
                        MyVideoPlayer(videoController: videoPlayerController),
                  );
                })));
              }),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  child: Stack(alignment: Alignment.center, children: [
                    Image.asset(
                      seasonsList[index].seasons[innerListIndex].imgPath,
                      width: customWidth(0.29),
                      height: customHeight(0.165),
                      //0.235
                      fit: BoxFit.fill,
                    ),
                  ])),
            ),
            Stack(children: [
              Container(
                height: customHeight(0.0025),
                width: customWidth(0.29),
                color: Colors.grey,
              ),
              Container(
                height: customHeight(0.0025),
                width: customWidth(0.12),
                color: Colors.red,
              ),
            ]),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(32, 29, 29, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              width: customWidth(0.29),
              height: customHeight(0.0475),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: customFontSize(0.055),
                  ),
                  Transform.rotate(
                      angle: 1.55,
                      child: Icon(
                        Icons.linear_scale_sharp,
                        color: Colors.white,
                        size: customFontSize(0.05),
                      ))
                ],
              ),
            )
          ],
        );
}

//Video box for showing the seasons already watch but not complete
class NumberingBox extends Column {
  BuildContext context;
  int index, innerListIndex;

  NumberingBox({
    super.key,
    required this.context,
    required this.index,
    required this.innerListIndex,
  }) : super(
          children: [
            Column(
              children: [
                SizedBox(
                  width: customWidth(0.45),
                  child: Stack(alignment: Alignment.bottomLeft, children: [
                    Container(
                      child: Positioned(
                        left: customWidth(0.04),
                        top: customHeight(0.08),
                        child: Text(
                          (innerListIndex + 1).toString(),
                          style: TextStyle(shadows: const [
                            Shadow(blurRadius: 4, color: Colors.white),
                            Shadow(
                                blurRadius: 35,
                                offset: Offset(-4, 0),
                                color: Color.fromARGB(255, 97, 91, 91))
                          ], fontSize: customFontSize(0.2)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            seasonsList[index].seasons[innerListIndex].imgPath,
                            width: customWidth(0.29),
                            height: customHeight(0.19),
                            //0.235
                            fit: BoxFit.fill,
                          )),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        );
}

//Scenes pop up add
class PopCornAdd extends Container {
  PopCornAdd()
      : super(
          width: customWidth(),
          height: customHeight(0.48),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                  colors: [
                Color.fromRGBO(69, 22, 75, 1),
                Colors.black,
                Colors.black,
                Colors.black,
                Color.fromRGBO(69, 22, 75, 1)
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
                "Short Clips.Big  \n     emotions.",
                style: TextStyle(
                    fontSize: customFontSize(0.07),
                    fontWeight: FontWeight.bold),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(207, 58, 47, 1),
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
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
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

//Gradient text widget for adding gradient in the text background
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

//list storing data of seasons
List<SeasonsModel> seasonsList = [
  SeasonsModel(title: "International Police and detective shows", seasons: [
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  //2nd
  SeasonsModel(title: "Continue Watching Season 2", seasons: [
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
  ]),
  //3rd
  SeasonsModel(title: "We picked these Games for you", seasons: [
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  SeasonsModel(title: "Season 8", seasons: [
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  //2nd
  SeasonsModel(title: "Awesome Movies", seasons: [
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
  ]),
  //3rd
  SeasonsModel(title: "Trending", seasons: [
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  SeasonsModel(title: "Best Seasons", seasons: [
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  //2nd
  SeasonsModel(title: "Movies you liked", seasons: [
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
  ]),
  //3rd
  SeasonsModel(title: "Indian Seasons", seasons: [
    SeasonInfo(
        name: "The Good Doctor",
        imgPath: "Assets/Images/seasons/thegooddoctor.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
  SeasonsModel(title: "Continue Watching Season 8", seasons: [
    SeasonInfo(name: "dynasty", imgPath: "Assets/Images/seasons/dynasty.jpg"),
    SeasonInfo(
        name: "Police University",
        imgPath: "Assets/Images/seasons/policeuni.jpg"),
    SeasonInfo(
        name: "The Good detective",
        imgPath: "Assets/Images/seasons/thegooddetective.jpg"),
    SeasonInfo(
        name: "The Watcher", imgPath: "Assets/Images/seasons/thewatcher.jpg"),
  ]),
];
//Banners data
List<RecommendBannerModel> listRecommendation = [
  RecommendBannerModel(
      imgPath: "Assets/Images/seasons/mrserialkiller.jpg",
      bgColor: Color.fromRGBO(20, 29, 68, 1),
      bottomColor: Colors.black),
];
//  Padding(
//                         padding: EdgeInsets.only(
//                             top: customHeight(0.012),
//                             left: customHeight(0.012)),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: ((context) => EpisodeScreen(
//                                           color: Colors.amber,
//                                         ))));
//                                 //   Navigator.of(context)
//                                 //       .pushNamed(EpisodeScreen.pageName);
//                               },
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(6),
//                                   child: Image.asset(
//                                     "Assets/Images/mirza.jpg",

//                                     width: customWidth(0.29),
//                                     height: customHeight(0.19),
//                                     //0.235
//                                     fit: BoxFit.cover,
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: customHeight(0.012),
//                             left: customHeight(0.012)),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               onTap: (() async {
//                                 await Future.delayed(
//                                     Duration(milliseconds: 500));
//                                 Navigator.of(context, rootNavigator: true).push(
//                                     PageRouteBuilder(pageBuilder: ((context,
//                                         animation, secondaryAnimation) {
//                                   return Material(
//                                     child: MyVideoPlayer(
//                                         videoController: videoController),
//                                   );
//                                 })));
//                                 SystemChrome.setPreferredOrientations([
//                                   DeviceOrientation.landscapeLeft,
//                                   DeviceOrientation.landscapeRight
//                                 ]);
//                               }),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(6),
//                                   child: Image.asset(
//                                     "Assets/Images/hero.jpg",
//                                     width: customWidth(0.29),
//                                     height: customHeight(0.19),
//                                     //0.235
//                                     fit: BoxFit.fill,
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: customHeight(0.012),
//                             left: customHeight(0.012)),
//                         child: Column(
//                           children: [
//                             ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: Image.asset(
//                                   "Assets/Images/hero.jpg",
//                                   width: customWidth(0.29),
//                                   height: customHeight(0.19),
//                                   //0.235
//                                   fit: BoxFit.fill,
//                                 )),
//                           ],
//                         ),
//                       ),