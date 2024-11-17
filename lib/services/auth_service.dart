import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? loggedInUser;

  //get the current user
  void getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.displayName);
        print(loggedInUser!.email);
        print(loggedInUser!.photoURL);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getCurrentUserName() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        final username = loggedInUser!.displayName;
        return username!;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> getCurrentUserImg() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        loggedInUser = user;
        final userImg = loggedInUser!.photoURL;
        return userImg!;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Google sign in
  signInWithGoogle() async {
    try {
      // begin with interactive sign in
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        String email = gUser.email;
        if (email.endsWith('@lamduan.mfu.ac.th')) {
          //obtain auth details from the request
          final GoogleSignInAuthentication gAuth = await gUser.authentication;
          //create a new credential for a new user
          final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          );
          return await _firebaseAuth.signInWithCredential(credential);
        } else {
          // Show an error message
          print("Only student emails are allowed!");
          // Optionally, sign out the user to clear session.
          return await GoogleSignIn().signOut();
        }
      } else {
        print('User canceled the sign-in process.');
        return null; // Return if the user cancels
      }
    } catch (e) {
      print('Google Sign-In error: $e');
      rethrow; // Rethrow to be caught by the onClick handler
    }
  }

  //Error Dialog
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Methods below are not in-use
  //email sign in
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      // sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // email sign up
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      // create user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'Exception: wrong-password':
        return 'The password is incorrect. Please try again';
      case 'Exception: user-not-found':
        return 'No user found with this email. Please Sign Up';
      case 'Exception: invalid email':
        return 'This email does not exist';
      default:
        return 'An unexpected error occured. Please try again later';
    }
  }
}
