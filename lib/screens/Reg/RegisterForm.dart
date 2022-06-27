import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/providers/UserProvider.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as fireauth;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final fireauth.FirebaseAuth auth = fireauth.FirebaseAuth.instance;
  bool _isLoading = false;

  String _userEmail = '';
  String _userName = '';
  late int _userAge;
  late UserProvider userProvider;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();

      String age = _ageController.text;
      String? _mobileNumber = auth.currentUser!.phoneNumber;
      _userAge = int.parse(age);

      print('Begin Upadting data');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
        'name': _userName,
        'email': _userEmail,
        'age': _userAge,
        'mobile_number': _mobileNumber
      }).whenComplete(() {
        print('done');
        userProvider.setUserDetails(_userName, _userEmail, _userAge,
            auth.currentUser!.uid, _mobileNumber);
      });

      await getIt<NavigationService>().navigateToandClearWithUserSigninCheck();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    SZ.init(context);
    return SafeArea(
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
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.button,
                          ),
                          onPressed: _trySubmit,
                          style: ElevatedButton.styleFrom(
                            primary: Style.PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(SZ.V * 1.2)),
                            padding: EdgeInsets.symmetric(
                                vertical: SZ.V * 1.8, horizontal: SZ.H * 27),
                          ),
                        ),
                      )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
