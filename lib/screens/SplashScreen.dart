import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";
  final String assetName = "assets/images/PWD.png";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool faded = false;
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1100), () {
      setState(() {
        opacity = 0.4;
      });
    });
    Timer(const Duration(milliseconds: 1800), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Timer(
      const Duration(milliseconds: 2700),
      () => getIt<NavigationService>().navigateToandClearWithUserSigninCheck(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: SZ.V * 85,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              child: Image.asset(
                widget.assetName,
                width: SZ.H * 40,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.white,
            child: Text(
              "Developed by Team pub.dev \n Version 1.0",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
