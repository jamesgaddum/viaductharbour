import 'package:flutter/material.dart';

class Themes {

  static ThemeData light(BuildContext context) => ThemeData.light().copyWith(
    accentColor: Color.fromRGBO(20, 190, 209, 1),
    primaryColor: Color.fromRGBO(242, 228, 217, 1),
    scaffoldBackgroundColor: Colors.white,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    indicatorColor: Colors.grey[300],
    textTheme: TextTheme(
      display1: TextStyle(
        letterSpacing: 5,
        fontSize: 18,
      ),
      body1: TextStyle(
        color: Colors.black,
        letterSpacing: 3,
        fontWeight: FontWeight.w700
      ),
      body2: TextStyle(
        color: Colors.black,
        letterSpacing: 2,
        fontSize: 11,
        fontWeight: FontWeight.w700
      ),
    ).apply(
      fontFamily: 'Gilroy',
    ),
    primaryTextTheme: TextTheme(
      display1: TextStyle(
        color: Colors.black,
        letterSpacing: 5,
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
      body1: TextStyle(
        color: Colors.black,
        letterSpacing: 3,
        fontWeight: FontWeight.w500
      ),
      body2: TextStyle(
        color: Colors.black,
        letterSpacing: 1.4,
        height: 1.4,
        fontWeight: FontWeight.w500
      )
    ).apply(
      fontFamily: 'Gilroy',
    ),
    accentTextTheme: TextTheme(
      body1: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 5
      )
    ).apply(
      fontFamily: 'Gilroy',
    ),
    appBarTheme: AppBarTheme.of(context).copyWith(
      color: Colors.white,
      actionsIconTheme: IconTheme.of(context).copyWith(
        color: Color.fromRGBO(20, 20, 20, 1)
      ),
      iconTheme: IconTheme.of(context).copyWith(
        color: Color.fromRGBO(20, 20, 20, 1)
      ),
    ),
    buttonTheme: ButtonThemeData(
      splashColor: Colors.transparent
    ),
    iconTheme: IconTheme.of(context).copyWith(
      color: Color.fromRGBO(20, 20, 20, 1)
    ),
  );
}
