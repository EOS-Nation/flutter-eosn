import 'package:flutter/material.dart';

class WalletAccountInfo extends StatelessWidget {
  final String accountName;
  final String publicKey;

  WalletAccountInfo(this.accountName, this.publicKey);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Account Name : ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(accountName),
          SizedBox(
            height: 10,
          ),
          Text(
            'Public Key :',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(publicKey),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('Set as current user'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
