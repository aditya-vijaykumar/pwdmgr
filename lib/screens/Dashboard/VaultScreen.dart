import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/models/PasswordEntryModel.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/screens/Dashboard/components/SearchField.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class VaultScreen extends StatelessWidget {
  VaultScreen({Key? key}) : super(key: key);
  final _search = TextEditingController();

  late MasterPasswordProvider masterPasswordProvider;

  @override
  Widget build(BuildContext context) {
    masterPasswordProvider = Provider.of<MasterPasswordProvider>(context);
    masterPasswordProvider.getAllPasswords();

    SZ.init(context);
    return ListView(
      children: [
        SizedBox(height: SZ.V * 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 5.0),
          child: SearchField(
            hintText: 'Search entries...',
            press: () {},
            search: _search,
          ),
        ),
        SizedBox(height: SZ.V * 5),

        PasswordEntryItem(
            pwd: PasswordEntryModel(
          id: "1",
          title: "Test App",
          username: "@Test01",
          password: "TestNOHACK",
          url: "Test.com",
          encryptedPassword: "0xTest",
          iv: "0xTest",
        )),

        ...masterPasswordProvider.passwordEntries
            .map((e) => PasswordEntryItem(pwd: e))
            .toList(),

        SizedBox(height: SZ.V * 2),
        // Login Text
      ],
    );
  }
}

class PasswordEntryItem extends StatelessWidget {
  PasswordEntryItem({Key? key, required this.pwd}) : super(key: key);
  PasswordEntryModel pwd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SZ.H * 8.0,
        vertical: SZ.V * 1.25,
      ),
      child: InkWell(
        onTap: () => showEntryOptions(context),
        child: Ink(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: SZ.H * 17.0,
                  height: SZ.H * 17.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SZ.V * 1.5),
                      color: Colors.black),
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pwd.title,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: SZ.V * 0.5),
                    Text(pwd.username,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: SZ.H * 7,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: SZ.H * 5, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEntryOptions(BuildContext context) {
    SZ.init(context);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SZ.H * 4.0),
            topRight: Radius.circular(SZ.H * 4.0),
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.remove_red_eye_outlined),
                title: const Text('View Password'),
                onTap: () {
                  Navigator.pop(context);
                  showDialogWithData(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.password),
                title: const Text('View Encrypted Data'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Details'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Entry'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void showDialogWithData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Title'),
          content: const Text('Content'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
