import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/pages/wrapper.dart';
import 'package:myapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
