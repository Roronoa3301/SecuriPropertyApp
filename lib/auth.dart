import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_secure_app/user.dart';

class AuthService {
  SignUser _signUser(User user) {
    return user != null ? SignUser(uid: user.uid) : null;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInEmailAndPass(String email, String password) async {
    try {
      print(email);
      print(password);
      var useremail = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user.email);

      // User firebaseUser = _authResult.user;
      return useremail;
    } on FirebaseAuthException catch (e) {
      return e.message;
      // print(e.toString());
    }
  }

  Future signUpWithEmailAndPasswordStudent(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      FirebaseFirestore.instance.collection("Users").doc(email).set({
        "uid": _auth.currentUser.uid,
        "username": username,
      }).then((value) => {});
      return _signUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateData(
    String password,
    String username,
  ) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser.email);
    Map<String, dynamic> users = {
      "username": username,
      "password": password,
    };
    documentReference.update(users).whenComplete(() {
      print("$username updated");
    });
    _auth.currentUser.updatePassword(password);
  }
}
