import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_campus_mobile_app/screen/home_page.dart';
import 'package:smart_campus_mobile_app/screen/navigation_screen.dart';
import '../components/google_signup_button.dart';
import '../components/login_button.dart';
import '../components/text_area.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = AuthService();
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/logo.png'),
                Text(
                  'Please use student mail to log in',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextArea(
                  hint: 'yourid@lamduan.mfu.ac.th',
                  fillColor: Colors.grey.shade100,
                  onChange: (value) {
                    email = value;
                  },
                  showText: false,
                ),
                SizedBox(
                  height: 20,
                ),
                TextArea(
                  hint: 'password',
                  fillColor: Colors.grey.shade100,
                  onChange: (value) {
                    password = value;
                  },
                  showText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                LoginButton(
                  buttonName: 'Log In',
                  onTouch: () async {
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Demo();
                          },
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: Divider(),
                ),
                SizedBox(
                  height: 30,
                ),
                GoogleSingUpButton(
                  img: 'images/google.png',
                  buttonName: 'Sing Up with Google',
                  onClick: () async {
                    try {
                      // Attempt to sign in with Google
                      UserCredential? userCredential =
                          await _authService.signInWithGoogle();

                      if (userCredential != null) {
                        // Navigate to LandingPage on success
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Demo(),
                          ),
                        );
                      } else {
                        // Handle case where sign-in fails or user cancels
                        _authService.showErrorDialog(context,
                            "Sign-in was canceled or email is invalid.");
                      }
                    } catch (e) {
                      // Catch and display any exceptions during the sign-in process
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Google Sign-In Failed'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
