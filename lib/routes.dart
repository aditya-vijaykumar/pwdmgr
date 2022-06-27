import 'package:flutter/material.dart';
import 'package:pwdmgr/screens/Dashboard/DashboardScreen.dart';
import 'package:pwdmgr/screens/Login/LoginScreen.dart';
import 'package:pwdmgr/screens/NewEntryScreen.dart';
import 'package:pwdmgr/screens/Reg/RegistrationScreen.dart';
import 'package:pwdmgr/screens/SplashScreen.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';

Widget _loadRoutePage(BuildContext context, Widget page) {
  SZ.init(context);
  return SafeArea(child: Theme(data: Style.THEME_DATA, child: page));
}

Route routerMethod(settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, const SplashScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    case LoginScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, const LoginScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    case RegisterScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, RegisterScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    case DashboardScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, DashboardScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    case NewEntryScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, const NewEntryScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    default:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => _loadRoutePage(_, const SplashScreen()),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
  }
}
