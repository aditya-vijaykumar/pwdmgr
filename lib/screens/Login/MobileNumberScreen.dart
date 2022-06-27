import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwdmgr/screens/Login/OTPScreen.dart';
import 'package:pwdmgr/services/FirebaseAuthService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pwdmgr/utils/Styles.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _formKey = GlobalKey<FormState>();

  late String mobileNumber;
  late String verificationId;
  late int resendToken;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SZ.H * 18.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyText1?.merge(
                    const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: SZ.H * 2.0),
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(right: SZ.H * 1.5, top: SZ.V * 1.4),
                      child: Text('+91',
                          style: Theme.of(context).textTheme.bodyText1?.merge(
                              const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600))),
                    ),
                    alignLabelWithHint: true,
                    hintText: 'Indian Mobile No.',
                    hintStyle: Theme.of(context).textTheme.bodyText1?.merge(
                        const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Mobile No.";
                  } else if (value.length < 10) {
                    return "Not 10 Digits";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    mobileNumber = value;
                  });
                },
              ),
            ),
          ),
          Container(
            child: codeSent
                ? const CircularProgressIndicator()
                : nextRoundButton(context),
          ),
          SizedBox(
            height: SZ.V * 7,
          ),
        ],
      ),
    );
  }

  Padding nextRoundButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: SZ.V * 2.0),
        child: Column(children: [
          MaterialButton(
            onPressed: () {
              setState(() {
                codeSent = true;
              });
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print('Mobile Number is $mobileNumber');
                verifyPhone(mobileNumber);
              }
            },
            color: Style.PRIMARY_COLOR,
            shape: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: SZ.V * 1.0,
          ),
          Text('Next', style: Theme.of(context).textTheme.bodyText2),
        ]));
  }

  /// Firebase Auth Functions

  Future<void> verifyPhone(String phoneNumber) async {
    verified(AuthCredential authResult) {
      FirebaseAuthService().signIn(authResult);
    }

    verificationfailed(FirebaseAuthException authException) {
      print('${authException.message}');
    }

    otpCodeSent(String verId, int? forceResend) {
      print('Sent Code');
      verificationId = verId;
      resendToken = forceResend!;
      setState(() {
        codeSent = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => OTPScreen(
            mobileNumber: '+91$mobileNumber',
            verificationId: verId,
            resentToken: resendToken,
          ),
        ),
      );
    }

    autoTimeout(String verId) {
      verificationId = verId;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: otpCodeSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
