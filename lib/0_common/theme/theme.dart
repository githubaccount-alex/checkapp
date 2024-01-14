import 'package:flutter/material.dart';

class CheckTheme {
  static final ThemeData materialLightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.pink[400],
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink[400],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pink[700],
        textTheme: ButtonTextTheme.primary,
      ),
      cardColor: Colors.lightBlueAccent[100],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white, type: BottomNavigationBarType.fixed, unselectedItemColor: Colors.grey, selectedItemColor: Colors.pink[400]));

  // Material Dark Theme
  static final ThemeData materialDarkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.pink[700],
      scaffoldBackgroundColor: Colors.blueGrey[900],
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pink[700],
        textTheme: ButtonTextTheme.primary,
      ),
      cardColor: Colors.lightBlueAccent[100],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black, type: BottomNavigationBarType.fixed, unselectedItemColor: Colors.black, selectedItemColor: Colors.pink[700]));
}
