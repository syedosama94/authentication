import 'package:flutter/foundation.dart';

class MyUser {
  final String id;
  final String name;
  final String email;
  MyUser._({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  factory MyUser.fromMap(Map data) {
    if (data['id'] == null) return null;

    return MyUser._(
      id: data['id'],
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
