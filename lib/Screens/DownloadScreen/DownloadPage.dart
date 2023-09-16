import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/Screens/DownloadScreen/DownloadPageWidgets.dart';

import 'package:video_player/video_player.dart';

class DownloadPage extends StatefulWidget {
  static const pageName = "/DownloadPage";
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
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
          //Sliver app bar showing heading and buttons
          DownloadSliverAppbar(
              backgroundColor: Color.fromRGBO(12, 10, 10, 0.8)),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.018)),
                  width: customWidth(0.94),
                  //Some details
                  child: AutoSizeText(
                    "Introducing Downloads for you",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: customFontSize(0.05)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: customHeight(0.012)),
                  width: customWidth(0.94),
                  child: AutoSizeText(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    maxLines: 8,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                        fontSize: customFontSize(0.03)),
                  ),
                ),
                //Netflix icon
                Image.asset(
                  "Assets/Images/netflixicon.png",
                  height: customHeight(0.3),
                ),
                ElevatedButton(
                    onPressed: (() {}),
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                            Size(customWidth(0.94), customHeight(0.06)))),
                    //Big blue button
                    child: Text(
                      "Set Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: customFontSize(0.04),
                          fontWeight: FontWeight.w400),
                    )),

                //Find more to download button
                Padding(
                  padding: EdgeInsets.only(top: customHeight(0.1)),
                  child: ElevatedButton(
                      onPressed: (() {}),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade800),
                          fixedSize: MaterialStatePropertyAll(
                              Size(customWidth(0.64), customHeight(0.05)))),
                      child: Text(
                        "Find More to Download",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: customFontSize(0.04),
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
