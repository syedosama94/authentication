import 'package:flutter/material.dart';

class FirebaseNotInitialize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(
        children: [
          Text('Something went wrong!', style: TextStyle(fontSize: 18)),
          Text('The app could not connect to the server right now!',
              style: TextStyle(fontSize: 18)),
        ],
      ),
    )));
  }
}
