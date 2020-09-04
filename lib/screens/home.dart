import 'package:authentication/services/auth_service.dart';

import '../models/quiz_model.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  AuthService _authService;
  BuildContext _mcontext;
  @override
  Widget build(BuildContext context) {
    _mcontext = context;
    _authService = Provider.of<AuthService>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          RaisedButton(
            onPressed: () => _authService.signOut(),
            child: Text('Sign Out'),
          )
        ])));
  }
}
