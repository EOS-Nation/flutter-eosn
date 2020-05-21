import 'package:flutter/material.dart';

class SelectDialog extends StatelessWidget {
  final String selectText;
  SelectDialog({this.selectText = ''});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(selectText),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('Cancel'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          child: Text('Select'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
