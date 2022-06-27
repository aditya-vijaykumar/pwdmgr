import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/providers/UserProvider.dart';

class NavigationService {
  final fireauth.FirebaseAuth auth = fireauth.FirebaseAuth.instance;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArguments(String routeName, Object arguments) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToandClear(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> navigateToWithArgumentsandClear(
      String routeName, Object arguments) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic> navigateToandClearWithUserSigninCheck() async {
    if (auth.currentUser == null) {
      return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false,
      );
    } else {
      await getIt<UserProvider>().fetchDetails();

      if (getIt<UserProvider>().userDetails.email.isEmpty) {
        return navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/register',
          (Route<dynamic> route) => false,
        );
      } else {
        if (await getIt<MasterPasswordProvider>().getKey()) {
          print(
              "Key is present in master password provider according to nav service");
          return navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
        } else {
          print(
              "Key is NOT present in master password provider according to nav service");
          return navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/masterPassword', (Route<dynamic> route) => false);
        }
      }
    }
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
