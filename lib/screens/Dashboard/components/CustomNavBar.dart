import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pwdmgr/utils/Styles.dart';
import 'package:pwdmgr/utils/Enumerations.dart';

class CutstomNavBar extends StatelessWidget {
  final NavBar currentTab;
  final Function onSelectTab;
  CutstomNavBar({required this.currentTab, required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return Container(
      height: SZ.H * 15,
      child: SafeArea(
          child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
                press: () => onSelectTab(NavBar.vault),
                iconEnum: Icons.lock_person_outlined,
                isActive: currentTab == NavBar.vault ? true : false),
            NavItem(
                press: () => onSelectTab(NavBar.settings),
                iconEnum: Icons.settings,
                isActive: currentTab == NavBar.settings ? true : false),
          ],
        ),
      )),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem(
      {Key? key,
      required this.press,
      required this.isActive,
      required this.iconEnum})
      : super(key: key);

  final VoidCallback press;
  final bool isActive;
  final IconData iconEnum;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      onDoubleTap: press,
      onLongPress: press,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
                width: SZ.H * 50.0,
                height: SZ.H * 1,
                color: isActive ? Style.PRIMARY_COLOR : null),
            Container(
              width: SZ.H * 7,
              height: SZ.H * 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SZ.H * 1.5),
              ),
              margin: EdgeInsets.symmetric(vertical: SZ.H * 3.5),
              child: Icon(
                iconEnum,
                color: isActive ? Style.PRIMARY_COLOR : Color(0xFFC4C4C4),
                size: SZ.H * 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
