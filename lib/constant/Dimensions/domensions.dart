import 'package:flutter/material.dart';

class Dimensions {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
  }

  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;

  static double font15 = screenHeight / 56.27;
  static double font20 = screenHeight / 42.2;
  static double font30 = screenHeight / 28.13;
  static double font26 = screenHeight / 32.46;

  static double raduis15 = screenHeight / 56.27;
  static double raduis20 = screenHeight / 42.2;
  static double raduis30 = screenHeight / 28.13;

// icon size
  static double iconsize24 = screenHeight / 35.17;
  static double iconsize16 = screenHeight / 52.75;

//list view size
  static double listviewimagesize = screenWidth / 3.25;
  static double listviewtextesize = screenWidth / 3.9;

  //populer food details ;
  static double populerfoodimgsize = screenHeight / 2.41;

  //bottom height
  static double bottomheight = screenHeight / 7.03;

//spalsh screen dimensions
  static double spalshImage = screenHeight / 3.2;
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = Dimensions.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// // Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = Dimensions.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
