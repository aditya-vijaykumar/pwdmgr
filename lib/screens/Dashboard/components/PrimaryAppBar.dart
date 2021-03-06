import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../utils/SizeConfig.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: Container(),
    primary: true,
    title: Container(
      margin: EdgeInsets.only(top: SZ.V * 1),
      child: Image.asset(
        'assets/images/H_PWDMGR.png',
        width: SZ.H * 25.0,
      ),
    ),
    centerTitle: true,
  );
}
