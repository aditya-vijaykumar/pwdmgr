import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class AboutAppScreen extends StatelessWidget {
  static const routeName = "/about";
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(height: SZ.V * 5),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SZ.V * 5.0, horizontal: SZ.H * 20),
              child: Center(
                  child: SvgPicture.asset(
                "assets/svg/PWDMGR.svg",
                fit: BoxFit.cover,
                width: SZ.H * 30,
              )),
            ),
            SizedBox(height: SZ.V * 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
              child: const Center(
                child: Text(
                  "This App has been built by Team pub.dev for Mobile App Development Lab and Cryptography & Network Security Lab mini projects. Team consists of:\n\nAditya Vijaykumar - 1NT9CS015\nVaibhav Jamwal - 1NT19CS209\nSharvin Pinto - 1NT19CS174",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: SZ.V * 10),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Version 1.0",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54),
              ),
            ),
          ],
        )));
  }
}
