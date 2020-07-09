import 'package:flutter/material.dart';
import 'package:myapp/pages/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF3a3a3a),
        primaryColorDark: Color(0xFF152026),
        buttonColor: Color(0xFFd66c44),
      ),
    );
  }
}
