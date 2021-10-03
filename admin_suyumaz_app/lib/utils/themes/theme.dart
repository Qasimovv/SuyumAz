/// This file defines the themes to be used in rest of the app.
/// Any user defined theme must always return the type [ThemeData]

import 'package:flutter/material.dart';

import '../fonts/fonts.dart';

class Themes {
  /// Returns default theme of new flutter app
  static ThemeData get defaultTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Themes.appBarColor,
        elevation: 15.0,
      ),
      primaryColor: Color(0xFF169BD5),
      accentColor: Color(0XFFD2D0FF),
      scaffoldBackgroundColor: Themes.canvasColor,
      fontFamily: Fonts.defaultFont,
    );
  }

  // Define custom themes here....

  //COLORS
  static const Color primaryColor = Color(0xFF169BD5);
  static const Color secondaryColor = Color(0xFF00ABB8);
  static const Color appBarColor = Colors.white;
  static const Color canvasColor = Colors.white;
  static const Color labelTextColor = Color(0xFF888888);
  static const Color statusBarColor = Color(0xFF00235F);
  static const Color seperatorColor = Color(0x44808080);
  static const Color fadedTextColor = Color(0XFFADADB0);
  static const Color darkFadedTextColor = Color(0XFF757575);
  static const Color switchColor = Color(0xFF9BCDC1);
  static const Color activeSwitchColor = Color(0xFF169BD5);
  static const Color inactiveSwitchColor = Color(0xFF78AA9E);
  static const Color checkBoxColor = Color(0xFF6190FF);
  static const Color redButtonColor = Color(0xFFFF4343);
  static const Color silverColor = Color.fromRGBO(214, 209, 203, 1);

  static const Color headerBlue = Color(0xff2079DF);
  static const Color bgPurple = Color(0xffF6F6FF);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color fadedBlue = Color(0x334A43FF);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color bgTable = Color(0x33D2D0FF);
  static const Color tooltipYellow = Color(0xffFFEB00);
  //GREY SHADES
  static const Color greyShadeSignupSignInPage = Color(0xFF888888);
  static const Color greyDisabledFields = Color(0xFFE3E3E6);
  static const Color textFieldsBackground = Color(0x22D2D0FF);
  static const Color dividerColor = Color(0xffdcdcde);
  static const Color greyDisabledText = Color(0xffA6A5A5);
  static const Color labelText = Color(0xFFAEAAAA);




}
