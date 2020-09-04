import '../../services/auth_service.dart';
import '../../widgets/action_btn.dart';
import '../../widgets/red_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final Function showSignUp;
  SignIn({@required this.showSignUp});

  String _email = '';
  String _password = '';

  RedText _emailError = RedText('');
  RedText _passwordError = RedText('');

  AuthService _authService;
  ActionBTN _signInBTN;

  @override
  Widget build(BuildContext context) {
    _authService = Provider.of<AuthService>(context);
    _signInBTN = ActionBTN(() => submit, 'Sign In', Color(0xff60BD87));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _signInText,
                SizedBox(height: 15),
                _emailInput,
                _emailError,
                SizedBox(height: 5),
                _passwordInput,
                SizedBox(height: 15),
                _signInBTN,
                SizedBox(height: 15),
                _signUpBTN
              ],
            ),
          ),
        )));
  }

  get _signInText => Text('Sign In!',
      style: TextStyle(
          color: Color(0xff60BD87), fontWeight: FontWeight.bold, fontSize: 30));

  get _emailInput => Container(
        decoration: BoxDecoration(
            // border: Border(bottom: BorderSide(color: Color(0xff027887)))
            border: Border.all(color: Color(0xff60BD87), width: 2),
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
            border: Border.all(color: Color(0xff60BD87), width: 2),
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

  get _signUpBTN => InkWell(
        onTap: () => showSignUp(),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xffe3b528),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up',
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

    bool hasErrors = true;
    if (!EmailValidator.validate(_email)) {
      _emailError.changeText('Inavlid email');
      hasErrors = false;
    }
    // if (_password.length < 6) {
    //   _passwordError.changeText('Password is too weak.');
    //   hasErrors = false;
    // }
    return hasErrors;
  }

  submit() async {
    if (_checkErrors) {
      _signInBTN.changeText('Working...');
      await _authService.signInWithEmailAndPassword(_email, _password);
      // _registerBTN.changeText('Register');
    }
  }
}
