import 'package:auth_using_hashing/models/user_model.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AuthControllers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign Up User
  Future<String> signUpUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    String res = 'Something went wrong';
    try {
      if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        //Hashing the password with salt
        String pwd = BCrypt.hashpw(password, BCrypt.gensalt());

        //Generating the User Id
        String uid = const Uuid().v1();

        //Signingup User
        User user =
            User(uId: uid, fullName: fullName, email: email, password: pwd);
        await _firestore.collection('users').doc(email).set(user.toJSON());
        res = 'Success';
      }
    } catch (err) {
      print(err.toString());
    }
    return res;
  }

  //Log In User
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    var userData = {};
    String res = 'Something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //Hashing the Entered Password with salt and trimming it to hash only exluding the salt
        String pwd = BCrypt.hashpw(password, BCrypt.gensalt()).substring(0, 6);

        //Getting the data of current user from the database
        var user = await _firestore.collection('users').doc(email).get();
        userData = user.data()!;

        //Triming the stored password to hash only and removing the salt from it for comparison
        String storedPassword = userData['password'].toString().substring(0, 6);

        if (userData['email'] == email && pwd == storedPassword) {
          res = 'Success';
        } else if (userData['email'] == email && pwd != storedPassword) {
          res = 'Invalid Credentials';
          // print(pswd);
        } else {
          res = 'Something went wrong';
        }
      }
    } catch (err) {
      print(res.toString());
    }
    return res;
  }
}
