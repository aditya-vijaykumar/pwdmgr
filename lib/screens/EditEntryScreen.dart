import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/models/PasswordEntryModel.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/screens/Dashboard/DashboardScreen.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';

class EditEntryScreen extends StatefulWidget {
  PasswordEntryModel pwd;
  EditEntryScreen({Key? key, required this.pwd}) : super(key: key);

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _urlController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  late MasterPasswordProvider masterPasswordProvider;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.pwd.title;
    _usernameController.text = widget.pwd.username;
    _urlController.text = widget.pwd.url;
    _passwordController.text = widget.pwd.password;
  }

  @override
  Widget build(BuildContext context) {
    masterPasswordProvider =
        Provider.of<MasterPasswordProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Entry',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Style.PRIMARY_COLOR,
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'App Name',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter the app name or account name',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter a valid app name or account name';
                      }
                      return null;
                    },
                    controller: _titleController,
                  ),
                  SizedBox(height: SZ.V * 1.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter the username',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    controller: _usernameController,
                  ),
                  SizedBox(height: SZ.V * 1.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Url',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter the url of app',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Please enter a valid url';
                      }
                      return null;
                    },
                    controller: _urlController,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Enter a secure password',
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: SZ.H * 3.0, bottom: SZ.V * 0.7),
                        child: IconButton(
                          onPressed: () => {
                            setState(
                                () => {_passwordVisible = !_passwordVisible})
                          },
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: _passwordVisible
                                ? Colors.black26
                                : Colors.black54,
                          ),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                          minWidth: SZ.H * 5.0, maxHeight: SZ.V * 5.0),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 10) {
                        return 'Password must be atleast 10 characters long';
                      } else if (value.length > 20) {
                        return 'Password must be less than 20 characters long';
                      } else if (value.contains(' ')) {
                        return 'Password cannot contain spaces';
                      } else if (value.contains('\n')) {
                        return 'Password cannot contain new lines';
                      }
                      return null;
                    },
                    controller: _passwordController,
                  ),
                  SizedBox(height: SZ.V * 1.0),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _passwordConfirmVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: Theme.of(context).textTheme.caption,
                      hintText: 'Re-enter the same password',
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: SZ.H * 3.0, bottom: SZ.V * 0.7),
                        child: IconButton(
                          onPressed: () => {
                            setState(() => {
                                  _passwordConfirmVisible =
                                      !_passwordConfirmVisible
                                })
                          },
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: _passwordConfirmVisible
                                ? Colors.black26
                                : Colors.black54,
                          ),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                          minWidth: SZ.H * 5.0, maxHeight: SZ.V * 5.0),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: _passwordConfirmController,
                  ),
                  SizedBox(height: SZ.V * 15.0),
                  _isLoading
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: EdgeInsets.only(bottom: SZ.V * 5),
                          child: ElevatedButton(
                            onPressed: () => _trySubmit(),
                            style: ElevatedButton.styleFrom(
                              primary: Style.PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(SZ.V * 1.2)),
                              padding: EdgeInsets.symmetric(
                                  vertical: SZ.V * 1.8, horizontal: SZ.H * 15),
                            ),
                            child: Text(
                              'Update Entry',
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

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();

      String _title = _titleController.text;
      String _username = _usernameController.text;
      String _url = _urlController.text;
      String _password = _passwordController.text;

      print('Begin storing new password');

      if (await masterPasswordProvider.updatePassword(
          widget.pwd.id, _title, _username, _url, _password, widget.pwd.iv)) {
        setState(() {
          _isLoading = false;
        });
        getIt<NavigationService>()
            .navigateToandClear(DashboardScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully updated the password!'),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating password'),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }
}
