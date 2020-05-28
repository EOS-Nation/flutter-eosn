import 'package:flutter/material.dart';

class ImportDialog extends StatelessWidget {
  final String selectText;
  final Function onSelect;
  ImportDialog({this.onSelect, this.selectText = ''});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Import'),
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
          child: Text('Import'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            onSelect();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
