import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/models/PasswordEntryModel.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/screens/Dashboard/components/SearchField.dart';
import 'package:pwdmgr/screens/EditEntryScreen.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class VaultScreen extends StatelessWidget {
  VaultScreen({Key? key}) : super(key: key);
  final _search = TextEditingController();

  late MasterPasswordProvider masterPasswordProvider;

  @override
  Widget build(BuildContext context) {
    final List<PasswordEntryModel> passwordEntries =
        getIt<MasterPasswordProvider>().passwordEntries;

    SZ.init(context);
    return SingleChildScrollView(
      child: FutureBuilder(
        future: getIt<MasterPasswordProvider>().getAllPasswords(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            print("snapshot.data");
            final List<PasswordEntryModel> pwdList =
                snapshot.data! as List<PasswordEntryModel>;

            return Column(
              children: [
                SizedBox(height: SZ.V * 5),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: SZ.H * 5.0),
                //   child: SearchField(
                //     hintText: 'Search entries...',
                //     press: () {},
                //     search: _search,
                //   ),
                // ),
                SizedBox(height: SZ.V * 5),
                ...List.generate(
                  pwdList.length,
                  (index) => PasswordEntryItem(
                    pwd: pwdList[index],
                  ),
                )
              ],
            );
          } else {
            return const Center(
                child: Text("No entries exist, please add one."));
          }
        },
      ),
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
                    // color: Colors.black,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/PWD.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
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
                leading: const Icon(Icons.text_format_rounded),
                title: const Text('View Details'),
                onTap: () {
                  Navigator.pop(context);
                  showAllDetails(
                      pwd.title, pwd.username, pwd.url, pwd.password, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_red_eye_outlined),
                title: const Text('View Password'),
                onTap: () {
                  Navigator.pop(context);
                  showAndCopyValue(pwd.password, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.password),
                title: const Text('View Encrypted Data'),
                onTap: () {
                  Navigator.pop(context);
                  showAndCopyValue(pwd.encryptedPassword, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Details'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEntryScreen(pwd: pwd),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Entry'),
                onTap: () {
                  Navigator.pop(context);
                  confirmDeleteEntry(pwd.id, pwd.title, context);
                },
              ),
            ],
          );
        });
  }

  void showAndCopyValue(String value, BuildContext context) {
    TextEditingController _pController = new TextEditingController()
      ..text = value;

    void onPress() async {
      await Clipboard.setData(ClipboardData(text: _pController.text));
      scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text('Copied to clipboard'),
      ));
    }

    Widget content = TextField(
      readOnly: true,
      controller: _pController,
      decoration: InputDecoration(
        icon: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () => onPress(),
        ),
      ),
    );

    showDialogWithData(context, "Show Password", onPress, content, "Copy");
  }

  void confirmDeleteEntry(String id, String title, BuildContext context) {
    Future<void> onPress() async {
      await getIt<MasterPasswordProvider>().deletePassword(id);
      scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text('Successfully deleted pwd titled $title'),
      ));
    }

    Widget content = Text(
        'Are you sure you want to delete password entry with title $title');

    showDialogWithData(context, "Delete Password", onPress, content, "Delete");
  }

  void showAllDetails(String title, String username, String url,
      String password, BuildContext context) {
    TextEditingController _pController = new TextEditingController()
      ..text = password;

    TextEditingController _urlController = new TextEditingController()
      ..text = url;

    TextEditingController _uController = new TextEditingController()
      ..text = username;

    Widget content = Container(
      height: SZ.V * 30.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            readOnly: true,
            controller: _urlController,
            decoration: InputDecoration(
                icon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: _urlController.text));
                    scaffoldMessengerKey.currentState!
                        .showSnackBar(const SnackBar(
                      content: Text('Url Copied to clipboard'),
                    ));
                  },
                ),
                labelText: "Url ",
                labelStyle: Theme.of(context).textTheme.caption),
          ),
          TextField(
            readOnly: true,
            controller: _uController,
            decoration: InputDecoration(
                icon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: _uController.text));
                    scaffoldMessengerKey.currentState!
                        .showSnackBar(const SnackBar(
                      content: Text('Username Copied to clipboard'),
                    ));
                  },
                ),
                labelText: "Username",
                labelStyle: Theme.of(context).textTheme.caption),
          ),
          TextField(
            readOnly: true,
            controller: _pController,
            decoration: InputDecoration(
                icon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: _pController.text));
                    scaffoldMessengerKey.currentState!
                        .showSnackBar(const SnackBar(
                      content: Text('Password Copied to clipboard'),
                    ));
                  },
                ),
                labelText: "Password",
                labelStyle: Theme.of(context).textTheme.caption),
          ),
        ],
      ),
    );

    showDialogWithData(context, title, () {}, content, "Ok");
  }

  void showDialogWithData(BuildContext context, String title,
      VoidCallback onPress, Widget content, String cta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(cta),
              onPressed: () {
                onPress();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
