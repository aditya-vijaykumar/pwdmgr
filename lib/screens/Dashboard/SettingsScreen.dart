import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: SZ.H * 3, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: SZ.H * 3, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8),
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
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
