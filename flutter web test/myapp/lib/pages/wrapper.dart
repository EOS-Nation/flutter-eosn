import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = User(uid: 'asdf');

    return user == null ? Home() : Home();
  }
}
