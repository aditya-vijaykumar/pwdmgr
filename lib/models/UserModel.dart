import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String fullName;
  String email;
  int age;
  String mobileNumber;
  String uid;

  User(
      {this.age = -1,
      this.email = "",
      this.fullName = "",
      this.uid = "",
      this.mobileNumber = ""});

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      uid: doc.id,
      fullName: doc.data()!["fullName"] as String,
      email: doc.data()!['email'] ?? '',
      mobileNumber: doc.data()!['mobileNumber'] ?? '',
      age: doc.data()!['age'] ?? '',
    );
  }

  void setData(DocumentSnapshot<Map<String, dynamic>> doc) {
    uid = doc.id;
    fullName = doc.data()!['fullName'] ?? '';
    email = doc.data()!['email'] ?? '';
    mobileNumber = doc.data()!['mobileNumber'] ?? '';
    age = doc.data()!['age'] ?? '';
  }

  Map<String, dynamic> getMap() {
    return {
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'age': age
    };
  }
}
