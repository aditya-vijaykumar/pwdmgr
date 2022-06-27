import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';

class NewEntryScreen extends StatefulWidget {
  static const routeName = "/newEntry";
  const NewEntryScreen({Key? key}) : super(key: key);

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  bool _isLoading = false;

  String _userEmail = '';
  String _userName = '';
  late int _userAge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Entry',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SZ.H * 10.0),
                child: Column(children: [
                  SizedBox(height: SZ.V * 7.5),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter your full name',
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2)
                        return 'Please enter your Full Name';
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!.trim();
                    },
                  ),
                  SizedBox(height: SZ.V * 1.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter your email address',
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email Address cannot be blank';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!.trim();
                    },
                  ),
                  SizedBox(height: SZ.V * 1.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter your age',
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) return 'Age cannot be empty';
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    controller: _ageController,
                  ),
                  SizedBox(height: SZ.V * 15.0),
                  _isLoading
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: EdgeInsets.only(bottom: SZ.V * 5),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Style.PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(SZ.V * 1.2)),
                              padding: EdgeInsets.symmetric(
                                  vertical: SZ.V * 1.8, horizontal: SZ.H * 15),
                            ),
                            child: Text(
                              'Create New Entry',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
