import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/screens/AboutAppScreen.dart';
import 'package:pwdmgr/screens/ShowProfileScreen.dart';
import 'package:pwdmgr/services/FirebaseAuthService.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return ListView(
      children: [
        SizedBox(height: SZ.V * 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () =>
                Navigator.pushNamed(context, ShowProfileScreen.routeName),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: SZ.H * 3, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () => Navigator.pushNamed(context, AboutAppScreen.routeName),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: SZ.H * 3, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              getIt<MasterPasswordProvider>().clearTheStore();
              await FirebaseAuthService.auth.signOut();
              getIt<NavigationService>()
                  .navigateToandClearWithUserSigninCheck();
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: SZ.H * 3, color: Colors.black),
          ),
        ),
        SizedBox(height: SZ.V * 2),
        // Login Text
      ],
    );
  }
}
