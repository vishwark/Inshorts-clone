import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AvatarTheme extends ThemeExtension<AvatarTheme> {
  final Color? backgroundColor;
  final Color? color;

  AvatarTheme({this.backgroundColor, this.color});

  @override
  AvatarTheme copyWith({Color? backgroundColor, Color? color}) {
    return AvatarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: color ?? this.color,
    );
  }

  @override
  AvatarTheme lerp(ThemeExtension<AvatarTheme>? other, double t) {
    if (other is! AvatarTheme) {
      return this;
    }
    return AvatarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      color: Color.lerp(color, other.color, t),
    );
  }
}

class MyThemeData {
  ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          primary: Colors.white,
          secondary: Colors.white),
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
        textTheme: ButtonTextTheme.accent,
      ),
      cardColor: Colors.grey[800],
      dividerColor: Colors.white30,
      iconTheme: IconThemeData(color: Colors.white70),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black),
      shadowColor: Color.fromARGB(221, 209, 202, 202),
      extensions: [
        AvatarTheme(
          backgroundColor: Colors.black,
          color: Colors.white,
        ),
      ],
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        brightness: Brightness.light,
        primary: Colors.black,
        secondary: Colors.black,
      ),
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(221, 50, 48, 48),
      ),
      extensions: [
        AvatarTheme(
          backgroundColor: Colors.white,
          color: Colors.black,
        ),
      ],
    );
  }
}
