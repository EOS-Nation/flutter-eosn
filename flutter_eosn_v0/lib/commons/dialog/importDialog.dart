import 'package:flutter/material.dart';

class ImportDialog extends StatelessWidget {
  final String text;
  final Function onImport;
  ImportDialog({this.onImport, this.text = ''});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Import'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(text),
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
          child: Text('Import'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            onImport();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
