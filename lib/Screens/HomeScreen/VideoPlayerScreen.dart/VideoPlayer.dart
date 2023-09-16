import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:netflix/Components/ScreenBasicElements.dart';
import 'package:netflix/main.dart';
import 'package:video_player/video_player.dart';

import '../EpisodeScreen/EpisodeScreenWidgets.dart';

class MyVideoPlayer extends StatefulWidget {
  VideoPlayerController videoController;
  static const pageName = "/VideoPlayer";
  MyVideoPlayer({super.key, required this.videoController});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    isVp = true;
    return Container(
      width: customWidth(),
      height: customHeight(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          //Simple video player
          VideoPlayer(widget.videoController),
          //Controls
          ControlsOverlay(
            controller: widget.videoController,
            initialStart: true,
          ),
          //Bottom red line showing progress of video
          VideoProgressIndicator(widget.videoController, allowScrubbing: true)
        ],
      ),
    );
  }
}

double degToRad(double deg) {
  return deg * 3.14 / 180;
}

// class CustomVideoControls extends StatefulWidget {
//   const CustomVideoControls({super.key});

//   @override
//   State<CustomVideoControls> createState() => _CustomVideoControlsState();
// }

// class _CustomVideoControlsState extends State<CustomVideoControls> {
//   double sliderValue = 0.8;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           child: Slider(
//               value: sliderValue,
//               onChanged: ((value) {
//                 setState(() {
//                   sliderValue = value;
//                 });
//               })),
//         ),
//         Text(
//           "Hello",
//           style: TextStyle(fontSize: customFontSize(0.05), color: Colors.white),
//         )
//       ],
//     );
//   }
//}
