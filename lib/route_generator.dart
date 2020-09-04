import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case 'register_password':
      //   return MaterialPageRoute(builder: (_) => SignUpPassword(data: args));
      // case 'chat_room':
      //   return MaterialPageRoute(builder: (_) => ChatRoom());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR!!!'),
        ),
      );
    });
  }
}
