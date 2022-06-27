import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            // Build Logos
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SZ.V * 15.0, horizontal: SZ.H * 20),
              child: Center(
                  child: Text('About',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6)),
            ),
            SizedBox(height: SZ.V * 2),
          ],
        )));
  }
}
