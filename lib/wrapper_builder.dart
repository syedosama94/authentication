import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class WrapperBuilder extends StatelessWidget {
  const WrapperBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<FBUser>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<FBUser>(
        stream: authService.fbUser,
        builder: (context, snapshot) {
          final fbUser = snapshot.data;
          return fbUser == null
              ? builder(context, snapshot)
              : MultiProvider(providers: [
                  Provider<UserService>(
                      create: (_) => UserService(uid: fbUser.uid)),
                ], child: builder(context, snapshot));
        });
  }
}
