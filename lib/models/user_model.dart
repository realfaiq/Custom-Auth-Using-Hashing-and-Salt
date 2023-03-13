import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uId;
  final String fullName;
  final String email;
  final String password;

  const User(
      {required this.uId,
      required this.fullName,
      required this.email,
      required this.password});

  //Converts and returns the data to object So we don't have to write it multiple times
  Map<String, dynamic> toJSON() =>
      {"uId": uId, "fullName": fullName, "email": email, "password": password};

  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return User(
      uId: snapShot['uId'],
      fullName: snapShot['fullName'],
      email: snapShot['email'],
      password: snapShot['password'],
    );
  }
}
