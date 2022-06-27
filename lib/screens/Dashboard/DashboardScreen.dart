import 'package:pwdmgr/screens/Dashboard/SettingsScreen.dart';
import 'package:pwdmgr/screens/Dashboard/VaultScreen.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pwdmgr/utils/Enumerations.dart';
import 'components/CustomNavBar.dart';
import 'components/PrimaryAppBar.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  NavBar currentTab = NavBar.vault;

  Widget _buildBody(NavBar pointer) {
    switch (pointer) {
      case NavBar.vault:
        return VaultScreen();
      case NavBar.settings:
        return SettingsScreen();
    }
  }

  void _currentTab(NavBar update) {
    setState(() {
      currentTab = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(child: _buildBody(currentTab)),
      bottomNavigationBar: CutstomNavBar(
        currentTab: currentTab,
        onSelectTab: _currentTab,
      ),
      floatingActionButton: currentTab == NavBar.vault
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/newEntry'),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
