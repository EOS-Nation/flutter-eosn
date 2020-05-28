import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EOSToast {
  void errorCenterShortToast(String msg) => _showCenterShortToast(2, msg);
  void warningCenterShortToast(String msg) => _showCenterShortToast(1, msg);
  void infoCenterShortToast(String msg) => _showCenterShortToast(0, msg);

  void _showCenterShortToast(int severity, String msg) {
    Color color;
    Color textColor;
    switch (severity) {
      case 2:
        color = Colors.red;
        textColor = Colors.black;
        break;
      case 1:
        color = Colors.amber;
        textColor = Colors.black;
        break;
      case 0:
        color = Color(0xFFd66c44);
        textColor = Colors.white;
        break;
      default:
        color = Colors.redAccent;
        textColor = Colors.black;
    }
    Fluttertoast.showToast(
        msg: msg ?? '',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: textColor,
        fontSize: 20.0);
  }
}
