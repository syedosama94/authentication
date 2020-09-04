import 'screens/authentication/authenticate.dart';
import 'screens/home.dart';
import 'screens/splash.dart';
import 'services/auth_service.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<FBUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? Home() : Authenticate();
    }
    return Splash();
  }
}
