import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData DarkTheme = ThemeData(
  primarySwatch: Colors.teal,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF292A2F),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.teal,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF292A2F),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: Colors.teal, size: 25),
  ),
  scaffoldBackgroundColor: const Color(0xFF292A2F),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0.0,
    backgroundColor: Color(0xFF292A2F),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    bodyText2: TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
  ),
  fontFamily: 'Font2',
);
