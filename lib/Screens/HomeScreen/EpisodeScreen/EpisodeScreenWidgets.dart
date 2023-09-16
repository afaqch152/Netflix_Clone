import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:video_player/video_player.dart';

import '../../../Components/ScreenBasicElements.dart';

//Episode screen top bar
class EpTopBar extends Row {
  EpTopBar({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
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
        );
}

//Video player
class EpisodeVideoPlayer extends Container {
  VideoPlayerController videoController;
  EpisodeVideoPlayer({super.key, required this.videoController})
      : super(
          margin: EdgeInsets.only(top: customHeight(0.02)),
          width: customWidth(),
          height: customHeight(0.26),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              //Simple video player
              VideoPlayer(videoController),
              //Controls
              ControlsOverlay(controller: videoController),
              //Bottom red line showing progress of video
              VideoProgressIndicator(videoController, allowScrubbing: true),
            ],
          ),
        );
}

//Widget showing video player controls
class ControlsOverlay extends StatefulWidget {
  bool initialStart;
  ControlsOverlay({required this.controller, this.initialStart = false});

  final VideoPlayerController controller;

  @override
  State<ControlsOverlay> createState() => ControlsOverlayState();
}

class ControlsOverlayState extends State<ControlsOverlay> {
  late IconData playPause;
  double scale = 1;
  @override
  void initState() {
    super.initState();
    playPause =
        widget.initialStart ? Icons.pause : Icons.play_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: InkWell(
            onTap: (() {
              controllsTrigger();
            }),
            child: Transform.scale(
              scale: scale,
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: InkWell(
                    onTap: (() {
                      widget.controller.value.isPlaying
                          ? {
                              setState(() {
                                playPause = Icons.play_arrow;
                              }),
                              widget.controller.pause(),
                            }
                          : {
                              setState(() {
                                playPause = Icons.pause;
                              }),
                              widget.controller.play(),
                            };
                    }),
                    child: Icon(
                      playPause,
                      color: Colors.white,
                      size: 60.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//Function for showing and hiding controls on user tap
  void controllsTrigger() {
    if (scale == 0) {
      setState(() {
        scale = 1;
      });
    } else {
      setState(() {
        scale = 0;
      });
    }
    // setState(() {
    //   scale = 1;
    // });

    // Timer.periodic(Duration(seconds: 4), ((timer) {

    //   timer.cancel();
    // }));
  }
}

//Video option rate,share etc
InkWell epOption({
  required String labelText,
  required IconData icon,
}) {
  return InkWell(
    onTap: (() {}),
    child: Container(
      width: customWidth(0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: Colors.white,
          size: customFontSize(0.06),
        ),
        FittedBox(
          child: Padding(
            padding: EdgeInsets.only(top: customHeight(0.008)),
            child: Text(
              labelText,
              style: TextStyle(
                  color: Colors.grey.shade400, fontSize: customFontSize(0.025)),
            ),
          ),
        )
      ]),
    ),
  );
}

//Center widget showing episode details
class EpDetailsWidget extends Column {
  String episodeName, releaseYear, restrictionClass, epDesc, starring, creaters;
  int totalEp, epNumber;

  EpDetailsWidget(
      {super.key,
      required this.episodeName,
      required this.releaseYear,
      required this.restrictionClass,
      required this.totalEp,
      required this.epNumber,
      this.epDesc =
          "He Thought finding a bag of cash would fix his broken family.But his windfall find soon puts him at the mercy of a drug cartel that's moved in next door.",
      this.starring = "  Jaunpur, Azamgarh, Ghazipur, Lucknow,Yazman",
      this.creaters = " Kim Jin,Junaid,Waheed.."})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                episodeName,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: customFontSize(0.06)),
              ),
            ),
            Row(
              children: [
                Text(
                  releaseYear,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: customFontSize(0.03)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: customWidth(0.018)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(2)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        restrictionClass,
                        style: TextStyle(
                            color: Colors.grey, fontSize: customFontSize(0.03)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: customWidth(0.018)),
                  child: Text(
                    "${totalEp} Episodes",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: customFontSize(0.03)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: customWidth(0.018)),
                  child: Icon(
                    Icons.message,
                    color: Colors.grey.shade400,
                    size: customFontSize(0.04),
                  ),
                )
              ],
            ),
            //Play button
            episodeButton(text: "Play", icon: Icons.play_arrow),
            //Download button
            episodeButton(
                text: "Download Ep$epNumber",
                icon: Icons.download_rounded,
                color: Colors.white,
                bgColor: Color.fromARGB(255, 71, 65, 65)),
            //Episode description and other detials
            AutoSizeText(
              epDesc,
              maxLines: 4,
              style: TextStyle(
                  fontSize: customFontSize(0.032), color: Colors.white),
            ),
            //Starring
            Row(
              children: [
                Text(
                  "Starring:",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: customFontSize(0.028),
                    color: Colors.grey.shade300,
                  ),
                ),
                Text(
                  starring,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: customFontSize(0.028),
                      color: Colors.grey.shade500),
                ),
              ],
            ),
            //Creaters
            Row(
              children: [
                Text(
                  "Creaters:",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: customFontSize(0.028),
                    color: Colors.grey.shade300,
                  ),
                ),
                Text(
                  creaters,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: customFontSize(0.028),
                      color: Colors.grey.shade500),
                ),
              ],
            ),
            //Episode Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                epOption(labelText: "My List", icon: Icons.trending_up),
                epOption(labelText: "Rate", icon: Icons.thumb_up_alt_outlined),
                epOption(labelText: "Share", icon: Icons.share),
                epOption(
                    labelText: "  Download\n10 Episodes",
                    icon: Icons.file_download_rounded)
              ],
            ),
          ],
        );
}

//Video options button
ElevatedButton episodeButton(
    {required String text,
    required IconData icon,
    Color color = Colors.black,
    Color bgColor = Colors.white}) {
  return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
          fixedSize: MaterialStatePropertyAll(
              Size(customWidth(), customHeight(0.065)))),
      onPressed: (() {}),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              icon,
              size: customFontSize(0.07),
              color: color,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: customFontSize(0.04),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ));
}

//Bottom tab bar with episodes,trailers and more option
class EpBottomTabBar extends StatefulWidget {
  const EpBottomTabBar({super.key});

  @override
  State<EpBottomTabBar> createState() => _tabBarState();
}

class _tabBarState extends State<EpBottomTabBar>
    with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController tabController;
  double height = customHeight();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: [
          TabBar(
            onTap: ((value) {
              setState(() {
                index = value;
                if (value == 0) {
                  height = customHeight();
                } else {
                  height = customHeight(0.8);
                }
              });
            }),
            indicatorWeight: 3,
            indicatorColor: Colors.red,
            tabs: <Widget>[
              epTabBarOption(text: "EPISODES"),
              epTabBarOption(text: "TRAILERS"),
              epTabBarOption(text: "MORE"),
            ],
          ),
          SizedBox(
            height: height,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  episodesWidget(),
                  trailerWidget(),
                  moreWidget(),
                ]),
          ),
        ],
      ),
    );
  }

//Tab bar top options widget
  Tab epTabBarOption({required String text}) {
    return Tab(
      icon: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: customFontSize(0.034), fontWeight: FontWeight.bold),
      ),
    );
  }
}

//Tab bar episode widget
Container episodesWidget() {
  return Container(
      width: customWidth(),
      child: Container(
        margin: EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: customHeight(0.02),
            top: customHeight(0.02)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Stack(children: [
                        Image.asset(
                          "Assets/Images/ironman.jpeg",
                          fit: BoxFit.fill,
                          width: customWidth(0.37),
                          height: customHeight(0.11),
                        ),
                        Container(
                          width: customWidth(0.37),
                          height: customHeight(0.11),
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                        )
                      ]),
                    ),
                    Container(
                      width: customWidth(0.37),
                      height: 2,
                      color: Colors.grey.shade800,
                    ),
                  ],
                ),
                SizedBox(
                  width: customWidth(0.54),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "1.Episode 1",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: customFontSize(0.04),
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: AutoSizeText(
                              "1h 2m",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: customFontSize(0.036),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.download_rounded,
                        size: customFontSize(0.07),
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: customHeight(0.01)),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
                style: TextStyle(
                  fontSize: customFontSize(0.03),
                  color: Colors.grey.shade500,
                ),
              ),
            )
          ],
        ),
      ));
}

//Tab bar trailer widget
Column trailerWidget() {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
            top: customHeight(0.015), bottom: customHeight(0.015)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "Assets/Images/munna.jpg",
                  fit: BoxFit.fill,
                  width: customWidth(0.95),
                  height: customHeight(0.25),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: customWidth(0.02), top: customHeight(0.01)),
                child: SizedBox(
                  width: customWidth(0.95),
                  child: AutoSizeText(
                    "Season 1 Teaser 1:The Marked Heart",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: customFontSize(0.035), color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            top: customHeight(0.015), bottom: customHeight(0.015)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "Assets/Images/munna.jpg",
                  fit: BoxFit.fill,
                  width: customWidth(0.95),
                  height: customHeight(0.25),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: customWidth(0.02), top: customHeight(0.01)),
                child: SizedBox(
                  width: customWidth(0.95),
                  child: AutoSizeText(
                    "Season 1 Teaser 1:The Marked Heart",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: customFontSize(0.035), color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

//Tab bar more widget
Widget moreWidget() {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GridView(
      physics: ScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.8,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        maxCrossAxisExtent: customWidth(0.34),
      ),
      children: [
        SizedBox(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          width: customWidth(0.29),
          height: customHeight(0.19),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          width: customWidth(0.29),
          height: customHeight(0.19),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          width: customWidth(0.29),
          height: customHeight(0.19),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          width: customWidth(0.29),
          height: customHeight(0.19),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "Assets/Images/mirza.jpg",

                //0.235
                fit: BoxFit.fill,
              )),
        ),
      ],
    ),
  );
}
