import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/user.dart';
import 'package:fluttereosnv0/pages/auth/authenticate.dart';
import 'package:fluttereosnv0/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null ? Authenticate() : Home();
  }
}
