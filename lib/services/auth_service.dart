import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
class FBUser {
  const FBUser({@required this.uid});
  final String uid;
}

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final subbieCollection =
      FirebaseFirestore.instance.collection('subbie');

  FBUser _userFromFirebase(User user) {
    return user == null ? null : FBUser(uid: user.uid);
  }

  //user stream
  Stream<FBUser> get fbUser {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> registerUser(
      {String email,
      String password,
      String firstName,
      String lastName,
      int phone}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      //create a new document for the user with the uid
      if (firebaseUser != null) {
        await subbieCollection.doc(firebaseUser.uid).set({
          'id': firebaseUser.uid,
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'email': email,
        });
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> checkEmail(String email) async {
    // print('i am above try');
    // try {
    //   print('i am in try');
    //   await _auth.signInWithEmailAndPassword(email: email, password: 'huhuhu');
    //   print('i am in try below await');
    // } catch (error) {
    //   print('i am in catch');
    //   return error;
    // }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
