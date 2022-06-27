import 'package:flutter_svg/flutter_svg.dart';
import 'package:pwdmgr/services/FirebaseAuthService.dart';
import 'package:pwdmgr/utils/SizeConfig.dart';
import 'package:pwdmgr/utils/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  final String verificationId;
  final resentToken;
  OTPScreen(
      {required this.mobileNumber,
      required this.verificationId,
      this.resentToken});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  // pin related
  final _pinCodeFormKey = GlobalKey<FormState>();
  TextEditingController pinTextEditingController = TextEditingController();
  String pin = '';

  late String mobileNumber;
  late String verificationId;
  bool codeSent = false;
  bool codeResent = false;

  final String assetName = "assets/svg/PWDMGR.svg";

  void initState() {
    super.initState();
    verificationId = widget.verificationId;
    mobileNumber = widget.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    SZ.init(context);
    return SafeArea(
      child: Theme(
        data: Style.THEME_DATA,
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(height: SZ.V * 5),
              // Build Logos
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SZ.V * 15.0, horizontal: SZ.H * 20),
                child: Center(
                    child: SvgPicture.asset(
                  assetName,
                  fit: BoxFit.cover,
                  width: SZ.H * 30,
                )),
              ),
              SizedBox(height: SZ.V * 2),
              // Login Text
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SZ.V * 2, horizontal: SZ.H * 15),
                child: Text('OTP Verification.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(child: pinBuilder(context)),
                    nextRoundButton(context),
                    SizedBox(
                      height: SZ.V * 7,
                    ),
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              pinTextEditingController.clear();
                            },
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: codeResent
                                ? null
                                : () {
                                    verifyPhone(widget.mobileNumber,
                                        widget.resentToken);
                                  },
                            child: const Text('Resend Code'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form pinBuilder(BuildContext context) {
    return Form(
      key: _pinCodeFormKey,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: SZ.H * 5),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: const TextStyle(
              color: Style.PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 4) {
                return "Complete the Code";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 40,
              inactiveColor: Colors.black,
              activeColor: Style.PRIMARY_ACCENT_COLOR,
              inactiveFillColor: Colors.transparent,
              selectedFillColor: Colors.transparent,
              selectedColor: Style.PRIMARY_COLOR,
              activeFillColor: Colors.transparent,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            controller: pinTextEditingController,
            keyboardType: TextInputType.number,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState(() {
                pin = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          )),
    );
  }

  /* 
    Firebase Verify Mobile No. func.
  */
  Future<void> verifyPhone(phoneNo, resentToken) async {
    verified(AuthCredential authResult) {
      FirebaseAuthService().signIn(authResult);
    }

    verificationfailed(FirebaseAuthException authException) {
      print('${authException.message}');
    }

    smsSent(String verId, int? forceResend) {
      verificationId = verId;
      setState(() {
        codeSent = true;
        codeResent = true;
      });
    }

    autoTimeout(String verId) {
      verificationId = verId;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
      forceResendingToken: resentToken,
    );
  }

  Padding nextRoundButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: SZ.V * 2.0),
        child: Column(children: [
          MaterialButton(
            onPressed: () {
              if (_pinCodeFormKey.currentState!.validate()) {
                print("Code is sent Arrow");
                FirebaseAuthService().signInWithOTP(pin, verificationId);
              }
            },
            color: Style.PRIMARY_COLOR,
            shape: const CircleBorder(),
            child: const Padding(
              padding: const EdgeInsets.all(15),
              child: const Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: SZ.V * 1.0,
          ),
          Text('Next', style: Theme.of(context).textTheme.bodyText2),
        ]));
  }

  Padding mobileNumberInputField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SZ.H * 18.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText1!.merge(const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600)),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: SZ.H * 2.0),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: SZ.H * 1.5, top: SZ.V * 1.4),
                child: Text('+91',
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600))),
              ),
              alignLabelWithHint: true,
              hintText: 'Indian Mobile No.',
              hintStyle: Theme.of(context).textTheme.bodyText1!.merge(
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
    );
  }
}
