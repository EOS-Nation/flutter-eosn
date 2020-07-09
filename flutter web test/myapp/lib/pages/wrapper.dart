import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/pages/auth/authenticate.dart';
import 'package:myapp/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null ? Authenticate() : Home();
  }
}
