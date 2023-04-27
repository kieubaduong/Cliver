import 'package:flutter/material.dart';

class CustomSize{
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}

double getFont(double size) {
  double defaultsSize = CustomSize.defaultSize! * size;
  return (defaultsSize / 10);
}

// Get the proportionate height as per screen size
double getHeight(double inputHeight) {
  double screenHeight = CustomSize.screenHeight!;
  // 812 is the layout height that designer use
  return (inputHeight / 896.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getWidth(double inputWidth) {
  double screenWidth = CustomSize.screenWidth!;
  // 375 is the layout width that Figma provides
  return (inputWidth / 414.0) * screenWidth;
}