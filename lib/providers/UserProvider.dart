import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:flutter/material.dart';
import 'package:pwdmgr/models/UserModel.dart';

final fireauth.FirebaseAuth auth = fireauth.FirebaseAuth.instance;

class UserProvider with ChangeNotifier {
  User _user = User();

  Map<String, dynamic> userData = {
    'fullName': '',
    'email': '',
    'profileImage': '',
    'age': 0
  };

  void setUserDetails(fullName, email, age, uid, mobileNumber) {
    _user.fullName = fullName;
    _user.email = email;
    if (age != 0 && age != null) {
      _user.age = age;
    }
    _user.uid = uid ?? "";
    _user.mobileNumber = mobileNumber;

    notifyListeners();
  }

  void updateDetails(fullName, email, age) {
    _user.fullName = fullName;
    _user.email = email;
    if (age != 0 && age != null) {
      _user.age = age;
    }

    notifyListeners();
  }

  Future<void> fetchDetails() async {
    print('Fetching User Details for ${auth.currentUser!.uid}');
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    print(snapshot.data());

    final data = snapshot.data();

    if (snapshot.data() != null) {
      print(data);
      print(snapshot.id);
      setUserDetails(data!['name'], data['email'], data['age'], snapshot.id,
          data['mobile_number']);
    }
  }

  User get userDetails {
    return _user;
  }
}
