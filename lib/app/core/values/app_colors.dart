import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors extends GetxController {
  static Color primaryColor = Colors.transparent;
  static Color secondaryColor = Colors.transparent;
  static Color backgroundColor = Colors.transparent;
  static Color lightGreyColor = Colors.transparent;
  static Color lightGreenColor = Colors.transparent;
  static Color blackColor = Colors.transparent;
  static Color selectedNavBarColor = Colors.transparent;
  static Color unselectedNavBarColor = Colors.transparent;
  static Color itemChildColor = Colors.white;
  static Color greyShadowColor = Colors.transparent;
  static Color backgroundColorHomeScreen = Colors.white;
  static Color textColor = Colors.black;
  static Color fillColorTextField = Colors.transparent;
  static Color iconFindColor = Colors.transparent;
  static Color metallicSilver = Colors.transparent;
  static Color primaryWhite = Colors.transparent;
  static Color primaryBlack = Colors.transparent;
  static Color cultured = Colors.transparent;
  static Color greenCrayola = Colors.transparent;
  static Color rajah = Colors.transparent;
  static Color scaffoldBackgroundColor = Colors.transparent;

  void changeColor(bool darkMode) {
    if( darkMode == true ) {
      primaryColor = const Color.fromARGB(255, 99, 199, 131);
      secondaryColor = const Color.fromRGBO(179, 178, 178, 1.0);
      backgroundColor = Colors.black;
      lightGreyColor = const Color.fromRGBO(145, 143, 183, 1);
      lightGreenColor = const Color.fromRGBO(27, 186, 133, 0.1);
      blackColor = const Color.fromRGBO(23, 43, 77, 1);
      selectedNavBarColor = const Color.fromRGBO(28, 185, 134, 1);
      unselectedNavBarColor = const Color.fromRGBO(179, 178, 178, 1.0);
      itemChildColor = Colors.white;
      greyShadowColor = const Color.fromRGBO(118, 140, 170, 0.16);
      backgroundColorHomeScreen = Colors.white;
      textColor = Colors.black;
      fillColorTextField = const Color(0xFFF4F4F5);
      iconFindColor = const Color(0xff1BBA85);
      metallicSilver = Colors.grey;
      primaryWhite = Colors.black;
      primaryBlack = Colors.white;
      cultured = const Color(0xffF4F4F5);
      greenCrayola = const Color(0xff1BBA85);
      rajah = const Color(0xffF3B357);
      scaffoldBackgroundColor = Colors.white.withOpacity(0.1);
    }
    else{
      primaryColor = const Color.fromRGBO(27, 186, 133, 1.0);
      secondaryColor = const Color.fromRGBO(179, 178, 178, 1.0);
      backgroundColor = const Color(0xffF3F5F6);
      lightGreyColor = const Color.fromRGBO(145, 143, 183, 1);
      lightGreenColor = const Color.fromRGBO(27, 186, 133, 0.1);
      blackColor = const Color.fromRGBO(23, 43, 77, 1);
      selectedNavBarColor = const Color.fromRGBO(28, 185, 134, 1);
      unselectedNavBarColor = const Color.fromRGBO(179, 178, 178, 1.0);
      itemChildColor = Colors.white;
      greyShadowColor = const Color.fromRGBO(118, 140, 170, 0.16);
      backgroundColorHomeScreen = Colors.white;
      textColor = Colors.black;
      fillColorTextField = const Color(0xFFF4F4F5);
      iconFindColor = const Color(0xff1BBA85);
      metallicSilver = const Color(0xffACAAA5);
      primaryWhite = Colors.white;
      primaryBlack = Colors.black;
      cultured = const Color(0xffF4F4F5);
      greenCrayola = const Color(0xff1BBA85);
      rajah = const Color(0xffF3B357);
      scaffoldBackgroundColor = const Color(0xffACAAA5).withOpacity(0.01);
    }
  }

  //==========================================================================//
  //LIGHT THEME
  ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: "SFProRounded",
        ),
    scaffoldBackgroundColor: const Color(0xffACAAA5).withOpacity(0.01),
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    hintColor: secondaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: backgroundColor,
    ),
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: Colors.white, filled: true),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black.withOpacity(0.5),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Color(0xff818383),
    ), bottomAppBarTheme: BottomAppBarTheme(color: backgroundColor),
  );

  //==========================================================================//
  //DARK THEME
  ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: "SFProRounded",
        ),
    scaffoldBackgroundColor: Colors.black54,
    colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
    hintColor: secondaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: backgroundColor,
    ),
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: Colors.black, filled: true),
    tabBarTheme: const TabBarTheme(labelColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Color(0xff818383),
    ), bottomAppBarTheme: BottomAppBarTheme(color: backgroundColor),
  );
}
