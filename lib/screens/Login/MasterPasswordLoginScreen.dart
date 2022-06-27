import 'package:pwdmgr/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/providers/UserProvider.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';

import 'package:firebase_auth/firebase_auth.dart' as fireauth;

class MasterPasswordLoginScreen extends StatelessWidget {
  static const routeName = "/masterPassword";

  const MasterPasswordLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Master Password',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: const MasterPasswordLoginForm(),
    );
  }
}

class MasterPasswordLoginForm extends StatefulWidget {
  const MasterPasswordLoginForm({Key? key}) : super(key: key);

  @override
  State<MasterPasswordLoginForm> createState() =>
      _MasterPasswordLoginFormState();
}

class _MasterPasswordLoginFormState extends State<MasterPasswordLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _masterPasswordController = TextEditingController();
  final fireauth.FirebaseAuth auth = fireauth.FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isWrongPassword = false;
  String _errorMessage = "";

  late UserProvider userProvider;
  late MasterPasswordProvider masterPasswordProvider;

  String _masterPassword = '';
  bool _masterPasswordVisble = false;

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();

      _masterPassword = _masterPasswordController.text;

      if (await masterPasswordProvider.accountReLoginSuccess(_masterPassword)) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isWrongPassword = true;
          _errorMessage = "Wrong master password, please try again";
        });
      }

      await getIt<NavigationService>().navigateToandClearWithUserSigninCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    masterPasswordProvider =
        Provider.of<MasterPasswordProvider>(context, listen: false);

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
                SizedBox(height: SZ.V * 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _masterPasswordVisble,
                  decoration: InputDecoration(
                    labelText: 'Master Password',
                    labelStyle: Theme.of(context).textTheme.caption,
                    hintText: 'Enter your previous master password',
                    suffixIcon: Padding(
                      padding:
                          EdgeInsets.only(left: SZ.H * 3.0, bottom: SZ.V * 0.7),
                      child: IconButton(
                        onPressed: () => {
                          setState(() =>
                              {_masterPasswordVisble = !_masterPasswordVisble})
                        },
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: _masterPasswordVisble
                              ? Colors.black54
                              : Colors.black26,
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  controller: _masterPasswordController,
                ),
                _isWrongPassword
                    ? SizedBox(
                        height: SZ.V * 15.0,
                        child: Center(
                          child: Text(
                            _errorMessage,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: SZ.V * 15.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.only(bottom: SZ.V * 5),
                        child: ElevatedButton(
                          onPressed: _trySubmit,
                          style: ElevatedButton.styleFrom(
                            primary: Style.PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(SZ.V * 1.2)),
                            padding: EdgeInsets.symmetric(
                                vertical: SZ.V * 1.8, horizontal: SZ.H * 24),
                          ),
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.button,
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
