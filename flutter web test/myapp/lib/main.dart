import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/pages/home/home.dart';
import 'package:myapp/pages/wrapper.dart';
import 'package:myapp/services/auth.dart';
import 'package:provider/provider.dart';

final bool useFirebaseLogin = false;

void main() =>
    runApp(useFirebaseLogin ? MyAppWithFirebase : MyAppWithoutFirebase());

class MyAppWithoutFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF3a3a3a),
        primaryColorDark: Color(0xFF152026),
        buttonColor: Color(0xFFd66c44),
      ),
    );
  }
}

class MyAppWithFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF3a3a3a),
          primaryColorDark: Color(0xFF152026),
          buttonColor: Color(0xFFd66c44),
        ),
      ),
    );
  }
}
