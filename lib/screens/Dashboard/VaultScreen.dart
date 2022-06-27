import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pwdmgr/screens/Dashboard/components/SearchField.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

class VaultScreen extends StatelessWidget {
  VaultScreen({Key? key}) : super(key: key);
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SZ.H * 8.0),
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
                        Text('Title and App Name',
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(height: SZ.V * 0.5),
                        Text('Entry 2',
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: SZ.H * 7,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.transparent,
                        ),
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            size: SZ.H * 5, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Build Logos
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SZ.V * 15.0, horizontal: SZ.H * 20),
          child: Center(
              child: Text('Vault',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6)),
        ),
        SizedBox(height: SZ.V * 2),
        // Login Text
      ],
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
                leading: const Icon(Icons.photo),
                title: const Text('Photo'),
                onTap: () {
                  Navigator.pop(context);
                  showDialogWithData(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text('Music'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Video'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
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
