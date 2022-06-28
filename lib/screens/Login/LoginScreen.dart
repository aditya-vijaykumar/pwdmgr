import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/SizeConfig.dart';
import 'MobileNumberScreen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(height: SZ.V * 5),
        // Build Logos
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SZ.V * 15.0, horizontal: SZ.H * 20),
          child: Center(
              child: Image.asset(
            "assets/images/PWDMGR.png",
            fit: BoxFit.cover,
            width: SZ.H * 30,
          )),
        ),
        SizedBox(height: SZ.V * 2),
        // Login Text
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SZ.V * 2, horizontal: SZ.H * 15),
          child: Text('Enter Mobile Number to Get Started.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
        ),
        MobileNumberScreen(),
      ],
    ));
  }
}
