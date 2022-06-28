import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/models/UserModel.dart';
import 'package:pwdmgr/providers/UserProvider.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';

class ShowProfileScreen extends StatelessWidget {
  static const String routeName = "showProfile";
  const ShowProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt<UserProvider>().fetchDetails();
    final User user = getIt<UserProvider>().userDetails;
    return SafeArea(
      child: Theme(
        data: Style.THEME_DATA,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile Details",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: SZ.H * 7.50),
            top: false,
            child: Column(
              children: [
                SizedBox(height: SZ.V * 5.0),
                Container(
                  height: SZ.V * 22.5,
                  width: SZ.V * 22.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Style.PRIMARY_COLOR, width: 3.0),
                  ),
                  padding: EdgeInsets.all(SZ.V * 0.7),
                  child: Container(
                    height: SZ.V * 21,
                    width: SZ.V * 21,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/UserAvatar.jpg')),
                  ),
                ),
                SizedBox(height: SZ.V * 2.0),
                Text(
                  user.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Spacer(flex: 1),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mobile Number',
                          style: Theme.of(context).textTheme.caption),
                      Text(user.mobileNumber,
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: SZ.V * 2.0),
                      Text('Email Address',
                          style: Theme.of(context).textTheme.caption),
                      Text(user.email,
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: SZ.V * 2.0),
                    ],
                  ),
                ),
                SizedBox(height: SZ.V * 5.0),
                Spacer(flex: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: SZ.V * 1.5),
                  alignment: Alignment(0, 0),
                  child: ElevatedButton(
                    child: Text(
                      'Go Back',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      primary: Style.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SZ.V * 1.2)),
                      padding: EdgeInsets.symmetric(
                          vertical: SZ.V * 1.8, horizontal: SZ.H * 27.5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
