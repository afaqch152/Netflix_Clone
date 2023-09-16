import 'package:flutter/material.dart';

import '../../Components/ScreenBasicElements.dart';

class DownloadSliverAppbar extends SliverAppBar {
  DownloadSliverAppbar({super.key, required super.backgroundColor})
      : super(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          expandedHeight: kToolbarHeight * 1.8,
          snap: true,
          title: DownloadBarRow(),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              bottom: customHeight(0.015),
            ),
            title: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: customWidth(0.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      size: customFontSize(0.034),
                      color: Colors.grey.shade400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        "Smart Downloads",
                        style: TextStyle(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w400,
                            fontSize: customFontSize(0.025)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
}

//Innser row for Games screen top bar
class DownloadBarRow extends Row {
  DownloadBarRow({super.key})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Downloads",
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
