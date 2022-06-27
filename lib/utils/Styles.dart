import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SizeConfig.dart';

class Style {
  // ignore: non_constant_identifier_names, constant_identifier_names
  static const Color PRIMARY_COLOR = Color(0xFFFAA424);
  // ignore: non_constant_identifier_names, constant_identifier_names
  static const Color PRIMARY_COLOR_DARK = Color.fromRGBO(30, 255, 100, 1);
  // ignore: non_constant_identifier_names, constant_identifier_names
  static const Color PRIMARY_ACCENT_COLOR = Color(0xFF11205c);
  static const Color addGrey = Color(0xFFEAEAEA);
  static const Color darkerGrey = Color(0xFFE1E1E1);

  static MaterialColor primarySwatch = const MaterialColor(
    0xFFFAA424,
    <int, Color>{
      50: Color(0xFFFAA424),
      100: Color(0xFFFAA424),
      200: Color(0xFFFAA424),
      300: Color(0xFFFAA424),
      400: Color(0xFFFAA424),
      500: Color(0xFFFAA424),
      600: Color(0xFFFAA424),
      700: Color(0xFFFAA424),
      800: Color(0xFFFAA424),
      900: Color(0xFFFAA424),
    },
  );

  // ignore: non_constant_identifier_names
  static final ThemeData THEME_DATA = ThemeData(
    fontFamily: 'poppins',
    primaryColor: Style.PRIMARY_COLOR,
    primarySwatch: Style.primarySwatch,
    backgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: TextTheme(
      headline1: GoogleFonts.poppins(
          fontSize: SZ.H * 18,
          fontWeight: FontWeight.w300,
          color: Colors.black),
      headline2: GoogleFonts.poppins(
          fontSize: SZ.H * 13,
          fontWeight: FontWeight.w300,
          color: Colors.black),
      headline3: GoogleFonts.poppins(
        fontSize: SZ.H * 10,
        color: Colors.black,
      ),
      headline4: GoogleFonts.poppins(
        fontSize: SZ.H * 8,
        color: Colors.black,
      ),
      headline5: GoogleFonts.poppins(
        fontSize: SZ.H * 6.5,
        color: Colors.black,
      ),
      headline6: GoogleFonts.poppins(
        fontSize: SZ.H * 5,
        color: Colors.black,
      ),
      subtitle1: GoogleFonts.poppins(
        fontSize: SZ.H * 4.6,
        color: Colors.black,
      ),
      subtitle2: GoogleFonts.poppins(
        fontSize: SZ.H * 4.4,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyText1: GoogleFonts.karla(
        fontSize: SZ.H * 4.2,
        color: Colors.black,
      ),
      bodyText2: GoogleFonts.karla(
        fontSize: SZ.H * 4,
        color: Colors.black,
      ),
      button: GoogleFonts.karla(
          fontSize: SZ.H * 5, fontWeight: FontWeight.bold, color: Colors.black),
      caption: GoogleFonts.karla(
        fontSize: SZ.H * 3.6,
        color: Colors.black,
      ),
      overline: GoogleFonts.karla(
        fontSize: SZ.H * 3.2,
        color: Colors.black,
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black));
}
