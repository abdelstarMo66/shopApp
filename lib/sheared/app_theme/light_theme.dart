import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: Colors.teal,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.teal, size: 25),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0.0,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
  ),
  fontFamily: 'Font2',
);
