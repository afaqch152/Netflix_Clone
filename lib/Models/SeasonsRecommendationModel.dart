import 'dart:ui';

class SeasonsModel {
  String title;
  List<SeasonInfo> seasons;
  SeasonsModel({required this.title, required this.seasons});
}

class SeasonInfo {
  String name;
  String imgPath;
  SeasonInfo({required this.name, required this.imgPath});
}

class RecommendBannerModel {
  String imgPath;
  Color bgColor;
  Color bottomColor;
  RecommendBannerModel(
      {required this.imgPath,
      required this.bgColor,
      required this.bottomColor});
}
