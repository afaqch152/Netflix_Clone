//HOmePageSliverappbar
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../Components/ScreenBasicElements.dart';
import '../HomeScreen/EpisodeScreen/EpisodeScreenWidgets.dart';
import '../HomeScreen/HomePageWidgets.dart';

class NewsSliverAppbar extends SliverAppBar {
  bool isScrolling;
  NewsSliverAppbar(
      {super.key, required super.backgroundColor, required this.isScrolling})
      : super(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          expandedHeight: kToolbarHeight * 2,
          snap: true,
          title: NewsBarRow(),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              bottom: customHeight(0.015),
            ),
            title: isScrolling
                ? Spacer()
                : SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(left: customWidth(0.02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NewsNavButton(
                              text: "Coming Soon",
                              isActive: true,
                            ),
                            NewsNavButton(text: "Everyone's Watching"),
                            NewsNavButton(text: "Games"),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
}

//Innser row for Games screen top bar
class NewsBarRow extends Row {
  NewsBarRow({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "News & hot",
              style: TextStyle(
                  color: Colors.white, fontSize: customFontSize(0.055)),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: customWidth(0.04)),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: customFontSize(0.068),
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

//Coming soon Banner
class ComingSoonBanner extends Row {
  VideoPlayerController videoPlayerController;
  ComingSoonBanner({super.key, required this.videoPlayerController})
      : super(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: customWidth(0.17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "APR",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 194, 191, 191),
                        fontSize: customFontSize(0.03)),
                  ),
                  Text(
                    "27",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.08)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: customWidth(0.77),
                      height: customHeight(0.2),
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
                    )),
                Padding(
                  padding: EdgeInsets.only(top: customHeight(0.006)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: customWidth(0.37),
                        child: AutoSizeText(
                          "Sweet Tooth",
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: customFontSize(0.06)),
                        ),
                      ),
                      epOption(
                          icon: Icons.notifications, labelText: "Remind Me"),
                      epOption(icon: Icons.info, labelText: "Info")
                    ],
                  ),
                ),
                //MOre information
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.018)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Season 2 Coming Thursday",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.04)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.012)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    maxLines: 8,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: customFontSize(0.03)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.012)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Hearfelt · Adventure · Armeggedon · US",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: customFontSize(0.032)),
                  ),
                ),
              ],
            )
          ],
        );
}

//Everyone's watching Banner
class EveryOneWatchingBanner extends Row {
  VideoPlayerController videoPlayerController;
  EveryOneWatchingBanner({super.key, required this.videoPlayerController})
      : super(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: customWidth(0.17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "APR",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 194, 191, 191),
                        fontSize: customFontSize(0.03)),
                  ),
                  Text(
                    "27",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.08)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: customWidth(0.77),
                      height: customHeight(0.2),
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
                    )),
                Padding(
                  padding: EdgeInsets.only(top: customHeight(0.006)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: customWidth(0.37),
                        child: AutoSizeText(
                          "Sweet Tooth",
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: customFontSize(0.06)),
                        ),
                      ),
                      epOption(
                          icon: Icons.notifications, labelText: "Remind Me"),
                      epOption(icon: Icons.info, labelText: "Info")
                    ],
                  ),
                ),
                //MOre information
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.018)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Season 2 Coming Thursday",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.04)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.012)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    maxLines: 8,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: customFontSize(0.03)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.012)),
                  width: customWidth(0.77),
                  child: AutoSizeText(
                    "Hearfelt · Adventure · Armeggedon · US",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: customFontSize(0.032)),
                  ),
                ),
              ],
            )
          ],
        );
}

//News Screen Navigation button widget
class NewsNavButton extends Container {
  final String text;
  final IconData icon;
  final bool isActive;
  NewsNavButton(
      {super.key,
      required this.text,
      this.icon = Icons.people_alt_outlined,
      this.isActive = false})
      : super(
          height: kToolbarHeight * 0.45,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: customWidth(0.02), right: customWidth(0.02)),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isActive ? Colors.black : Colors.white,
                    size: customFontSize(0.03),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: isActive ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: customFontSize(0.022)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
