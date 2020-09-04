import 'signin.dart';
import 'signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;

  @override
  Widget build(BuildContext context) {
    return _showSignIn
        ? SignIn(showSignUp: () => setState(() => _showSignIn = false))
        : SignUp(showSignIn: () => setState(() => _showSignIn = true));
  }
}
