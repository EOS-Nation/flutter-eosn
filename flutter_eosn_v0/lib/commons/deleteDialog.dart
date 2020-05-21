import 'package:flutter/material.dart';

const String defaultDeleteText = 'Are you sure you want to delete';

class DeleteDialog extends StatelessWidget {
  final String deleteText;
  DeleteDialog({this.deleteText = defaultDeleteText});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(deleteText),
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
          child: Text('Delete'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
