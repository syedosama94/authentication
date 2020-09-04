import 'package:authentication/services/auth_service.dart';
import '../../widgets/action_btn.dart';
import '../../widgets/red_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final Function showSignIn;
  SignUp({@required this.showSignIn});

  String _email = '';
  String _password = '';
  String _repeatPassword = '';

  AuthService _authService;
  ActionBTN _registerBTN;
  RedText _emailError = RedText('');
  RedText _passwordError = RedText('');
  RedText _repeatPasswordError = RedText('');

  @override
  Widget build(BuildContext context) {
    _authService = Provider.of<AuthService>(context);
    _registerBTN = ActionBTN(() => submit, 'Register', Color(0xffe3b528));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _signUpText,
                SizedBox(height: 15),
                _emailInput,
                _emailError,
                SizedBox(height: 10),
                _passwordInput,
                _passwordError,
                SizedBox(height: 10),
                _repeatPasswordInput,
                _repeatPasswordError,
                SizedBox(height: 10),
                _registerBTN,
                SizedBox(height: 15),
                Divider(thickness: 1, color: Colors.grey),
                SizedBox(height: 15),
                _signInBTN,
              ],
            ),
          ),
        )));
  }

  get _signUpText => Text('Sign Up!',
      style: TextStyle(
          color: Color(0xffe3b528), fontWeight: FontWeight.bold, fontSize: 30));

  get _emailInput => Container(
        decoration: BoxDecoration(
            // border: Border(bottom: BorderSide(color: Color(0xff027887)))
            border: Border.all(color: Color(0xffe3b528), width: 2),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 15),
        child: TextField(
          onChanged: (value) => _email = value,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              // labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xff027887)),
              hintText: 'Enter Email'),
        ),
      );

  get _passwordInput => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffe3b528), width: 2),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 15),
        child: TextField(
          onChanged: (value) => _password = value,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              // labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xff027887)),
              hintText: 'Enter Password'),
        ),
      );

  get _repeatPasswordInput => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffe3b528), width: 2),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 15),
        child: TextField(
          onChanged: (value) => _repeatPassword = value,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              // labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xff027887)),
              hintText: 'Repeat Password'),
        ),
      );

  get _signUpBTN => InkWell(
        onTap: () => submit(),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xffe3b528),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );

  get _signInBTN => InkWell(
        onTap: () => showSignIn(),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xff60BD87),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Go to Sign In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );

  bool get _checkErrors {
    //first reset errors
    _emailError.changeText('');
    _passwordError.changeText('');
    _repeatPasswordError.changeText('');

    bool hasErrors = true;
    if (!EmailValidator.validate(_email)) {
      _emailError.changeText('Inavlid email');
      hasErrors = false;
    }
    if (_password.length < 6) {
      _passwordError.changeText('Password is too weak.');
      hasErrors = false;
    }
    if (_password.compareTo(_repeatPassword) != 0) {
      _repeatPasswordError.changeText('Passwords do not match');
      hasErrors = false;
    }
    return hasErrors;
  }

  submit() async {
    if (_checkErrors) {
      _registerBTN.changeText('Working...');
      await _authService.registerUser(email: _email, password: _password);
      // _registerBTN.changeText('Register');
    }
  }
}
