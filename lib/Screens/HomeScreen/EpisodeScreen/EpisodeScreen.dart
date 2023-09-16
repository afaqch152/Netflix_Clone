import 'package:flutter/material.dart';

import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/Screens/HomeScreen/EpisodeScreen/EpisodeScreenWidgets.dart';
import 'package:netflix/main.dart';

import 'package:video_player/video_player.dart';

class EpisodeScreen extends StatefulWidget {
  Color color;

  static const pageName = "/EpisodeScreen";

  EpisodeScreen({super.key, required this.color});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  late VideoPlayerController _videoController;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isVp = false;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: customHeight(0.06)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Top bar showing backbutton and profile icon
              Padding(
                  padding: EdgeInsets.only(
                      left: customWidth(0.05), right: customWidth(0.05)),
                  child: EpTopBar()),
              //Episode Video
              EpisodeVideoPlayer(videoController: _videoController),
              //Episode details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: customHeight(0.5),
                  child: EpDetailsWidget(
                      episodeName: "A Model Family",
                      releaseYear: "2020",
                      restrictionClass: "18+",
                      epNumber: 2,
                      totalEp: 10),
                ),
              ),
              //Partition line before the bottom tab bar
              Container(
                width: customWidth(),
                height: 2,
                color: Colors.grey.shade800,
              ),
              //Bottom tab bar
              const EpBottomTabBar()
            ],
          ),
        ),
      ),
    );
  }
}
