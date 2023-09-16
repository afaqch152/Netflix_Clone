import 'package:flutter/material.dart';
import 'package:netflix/main.dart';

import 'ScreenBasicElements.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.onClick});
  VoidCallback onClick;

  @override
  State<BottomBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(18, 18, 18, 1),
        ),
        width: customWidth(),
        height: customHeight(0.074),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomBarItem(
              index: 0,
              labelText: "Explore",
              icon: Icons.search,
              onClick: widget.onClick,
            ),
            bottomBarItem(
              index: 1,
              labelText: "Games",
              icon: Icons.games,
              onClick: widget.onClick,
            ),
            bottomBarItem(
              index: 2,
              labelText: "News & hot",
              icon: Icons.newspaper,
              onClick: widget.onClick,
            ),
            bottomBarItem(
              index: 3,
              labelText: "Downloads",
              icon: Icons.downloading_rounded,
              onClick: widget.onClick,
            ),
          ],
        ));
  }

  Widget bottomBarItem(
      {required String labelText,
      required IconData icon,
      required int index,
      required VoidCallback onClick,
      Color? color}) {
    color = index == screenIndex
        ? Colors.white
        : const Color.fromRGBO(116, 116, 119, 1);
    return InkWell(
      onTap: (() {
        setState(() {
          //Changing selected icon value onclick
          screenIndex = index;
          //calling onclick to mark the main state dirty so it change the screen on pressing
          onClick.call();
        });
      }),
      child: Container(
        width: customWidth(0.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: color,
            //To increase the size of selected icon
            size: customFontSize(0.058) + ((screenIndex == index) ? 3 : 0),
          ),
          FittedBox(
            child: Padding(
              padding: EdgeInsets.only(top: customHeight(0.001)),
              child: Text(
                labelText,
                style: TextStyle(color: color, fontSize: customFontSize(0.023)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
