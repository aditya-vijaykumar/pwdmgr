import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwdmgr/main.dart';
import 'package:pwdmgr/services/NavigationService.dart';

class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  bool isUserSignedIn = false;

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds).then((value) => {
          getIt<NavigationService>().navigateToandClearWithUserSigninCheck(),
        });
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  status() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
