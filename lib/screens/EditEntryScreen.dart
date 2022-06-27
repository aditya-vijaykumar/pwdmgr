import 'package:flutter/material.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';

class EditEntryScreen extends StatelessWidget {
  static final routeName = "/updateProfile";
  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return SafeArea(
      child: Theme(
        data: Style.THEME_DATA,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Entry',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: EditEntryForm(),
        ),
      ),
    );
  }
}

class EditEntryForm extends StatefulWidget {
  const EditEntryForm({Key? key}) : super(key: key);

  @override
  State<EditEntryForm> createState() => _EditEntryFormState();
}

class _EditEntryFormState extends State<EditEntryForm> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: SZ.V * 5),
        // Build Logos
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SZ.V * 15.0, horizontal: SZ.H * 20),
          child: Center(
              child: Text('Edit Entry',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6)),
        ),
        SizedBox(height: SZ.V * 2),
        // Login Text
      ],
    );
  }
}
