import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:flutter/material.dart';
import 'package:pwdmgr/models/PasswordEntryModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final fireauth.FirebaseAuth auth = fireauth.FirebaseAuth.instance;

class MasterPasswordProvider with ChangeNotifier {
  static const String _PWDMASTERKEY = 'pwdmasterkey';
  final _storage = FlutterSecureStorage();
  final _accountNameController = TextEditingController(text: 'pwd_mgr');
  IOSOptions _getIOSOptions() => IOSOptions(
        accountName: _getAccountName(),
      );
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  String? _getAccountName() =>
      _accountNameController.text.isEmpty ? null : _accountNameController.text;

  bool _saltPairCreated = false;
  bool _keyPairFound = false;
  late enc.Key _masterKey;
  List<PasswordEntryModel> passwordEntries = [];

  void newAccountPassword(String masterPassword) async {
    print("newAccountPassword called");
    const plainText = 'TheSaltIsAllAboutMinions';
    final key = enc.Key.fromUtf8(masterPassword.padRight(32, '#'));
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // enc.Encrypted  ab = enc.Encrypted.fromBase64(encrypted.base64);

    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    if (decrypted == plainText) {
      print("KEY BEING WRITTEN");
      await _storage
          .write(
            key: _PWDMASTERKEY,
            value: key.base64,
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions(),
          )
          .then((_) => {print("KEY STOREDD")});

      await FirebaseFirestore.instance
          .collection('saltCheck')
          .doc(auth.currentUser!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'salt': plainText,
        'cipher': encrypted.base64,
        'iv': iv.base64,
      });
    } else {
      print("Decryption Failed");
    }
  }

  Future<bool> accountReLoginSuccess(String masterPassword) async {
    final snaspshot = await FirebaseFirestore.instance
        .collection('saltCheck')
        .doc(auth.currentUser!.uid)
        .get();
    print(snaspshot.data());

    final data = snaspshot.data();

    if (data != null) {
      final key = enc.Key.fromUtf8(masterPassword.padRight(32, '#'));
      final encrypter = enc.Encrypter(enc.AES(key));
      final iv = enc.IV.fromBase64(data['iv']);
      final decrypted =
          encrypter.decrypt(enc.Encrypted.fromBase64(data['cipher']), iv: iv);
      if (decrypted == data['salt']) {
        print("KEY BEING WRITTEN");
        await _storage
            .write(
              key: _PWDMASTERKEY,
              value: key.base64,
              iOptions: _getIOSOptions(),
              aOptions: _getAndroidOptions(),
            )
            .then((_) => {print("KEY STOREDD")});
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> getKey() async {
    final key = await _storage.read(
      key: _PWDMASTERKEY,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    if (key != null) {
      _keyPairFound = true;
      _masterKey = enc.Key.fromBase64(key);
    } else {
      _keyPairFound = false;
    }
    notifyListeners();
    return _keyPairFound;
  }

  Future<List<PasswordEntryModel>> _getAllPasswords() async {
    List<PasswordEntryModel> passwords = [];

    final encrypter = enc.Encrypter(enc.AES(_masterKey));

    final stream = await FirebaseFirestore.instance
        .collection('passwords')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .get();

    stream.docs.forEach((pwd) {
      final iv = enc.IV.fromBase64(pwd.data()['iv']);
      final encrypted = enc.Encrypted.from64(pwd.data()['password']);
      String decryptPassword = encrypter.decrypt(encrypted, iv: iv);
      PasswordEntryModel pwdModel = PasswordEntryModel(
        id: pwd.id,
        title: pwd.data()['title'],
        username: pwd.data()['username'],
        url: pwd.data()['url'],
        password: decryptPassword,
        encryptedPassword: pwd.data()['password'],
        iv: pwd.data()['iv'],
      );
      passwords.add(pwdModel);
    });

    return passwords;
  }

  void getAllPasswords() async {
    if (!_keyPairFound) {
      await getKey();
    }
    passwordEntries = await _getAllPasswords();
  }

  Future<bool> storePassword(
      String title, String username, String url, String password) async {
    if (!_keyPairFound) {
      await getKey();
    }
    final iv = enc.IV.fromLength(16);
    final encrypter = enc.Encrypter(enc.AES(_masterKey));
    final encrypted = encrypter.encrypt(password, iv: iv);
    final docRef =
        await FirebaseFirestore.instance.collection('passwords').add({
      'uid': auth.currentUser!.uid,
      'title': title,
      'username': username,
      'url': url,
      'password': encrypted.base64,
      'iv': iv.base64,
    });
    final pwdModel = PasswordEntryModel(
        id: docRef.id,
        title: title,
        username: username,
        url: url,
        password: password,
        encryptedPassword: encrypted.base64,
        iv: iv.base64);
    passwordEntries.add(pwdModel);
    notifyListeners();
    return true;
  }

  void deletePassword(String id) async {
    await FirebaseFirestore.instance
        .collection('passwords')
        .doc(id)
        .delete()
        .then((value) => {
              passwordEntries.removeWhere((element) => element.id == id),
              notifyListeners(),
            })
        .catchError((onError) => {
              print(onError),
              notifyListeners(),
            });
  }

  void updatePassword(String id, String title, String username, String url,
      String password, String ivb64) async {
    if (!_keyPairFound) {
      await getKey();
    }
    final iv = enc.IV.fromBase64(ivb64);
    final encrypter = enc.Encrypter(enc.AES(_masterKey));
    final encrypted = encrypter.encrypt(password, iv: iv);
    await FirebaseFirestore.instance.collection('passwords').doc(id).update({
      'title': title,
      'username': username,
      'url': url,
      'password': encrypted.base64,
    });
    passwordEntries.removeWhere((element) => element.id == id);
    PasswordEntryModel pwdModel = PasswordEntryModel(
      id: id,
      title: title,
      username: username,
      url: url,
      password: password,
      encryptedPassword: encrypted.base64,
      iv: iv.base64,
    );
    passwordEntries.add(pwdModel);
    notifyListeners();
  }
}
