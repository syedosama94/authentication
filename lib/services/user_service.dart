import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final userCollection = FirebaseFirestore.instance.collection('user');
  final uid;

  UserService({@required this.uid});

  Stream<MyUser> get streamUser => userCollection
      .doc(uid)
      .snapshots()
      .map((snap) => MyUser.fromMap(snap.data()));
}
