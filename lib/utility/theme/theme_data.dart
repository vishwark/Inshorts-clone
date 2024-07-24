import 'package:flutter/material.dart';

class MyThemeData {
  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      hintColor: Colors.tealAccent,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
      ),
      cardColor: Colors.grey[800],
      dividerColor: Colors.white30,
      iconTheme: IconThemeData(color: Colors.white70),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
      cardColor: Colors.white,
      dividerColor: Colors.black12,
      iconTheme: IconThemeData(color: Colors.black54),
    );
  }
}
