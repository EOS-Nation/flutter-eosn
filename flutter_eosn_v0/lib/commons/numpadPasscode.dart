import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:fluttereosnv0/commons/eosToast.dart';

class NumpadPasscode extends StatefulWidget {
  final Function onSubmit;

  NumpadPasscode(this.onSubmit);

  @override
  _NumpadPasscodeState createState() => _NumpadPasscodeState();
}

class _NumpadPasscodeState extends State<NumpadPasscode> {
  final NumpadController _numpadController =
      NumpadController(format: NumpadFormat.NONE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 50),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: NumpadText(
                style: TextStyle(fontSize: 40),
                controller: _numpadController,
              ),
            ),
            Expanded(
              child: Numpad(
                buttonColor: Theme.of(context).buttonColor,
                controller: _numpadController,
                buttonTextSize: 40,
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 30),
                ),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  String passcode = _numpadController.rawString as String;
                  if (passcode == null || passcode.length < 5) {
                    EOSToast().warningCenterShortToast(
                        'Enter a passcode at least 5 characters long');
                  } else {
                    widget.onSubmit(passcode);
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
