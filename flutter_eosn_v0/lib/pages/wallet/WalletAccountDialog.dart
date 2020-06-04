import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';

class WalletAccountdialog extends StatefulWidget {
  final Function onAdd;
  final Function onEdit;
  final WalletAccount walletAccount;
  final bool isNew;

  WalletAccountdialog(
      {this.onEdit, this.onAdd, this.walletAccount, this.isNew = true});

  @override
  _WalletAccountdialogState createState() => _WalletAccountdialogState();
}

class _WalletAccountdialogState extends State<WalletAccountdialog> {
  String id;
  String accountName;
  String publicKey;
  String privateKey;

  @override
  void initState() {
    super.initState();
    id = widget.walletAccount?.id ?? '';
    accountName = widget.walletAccount?.accountName ?? '';
    publicKey = widget.walletAccount?.publicKey ?? '';
    privateKey = widget.walletAccount?.privateKey ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Account Name : ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            TextFormField(
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).buttonColor, width: 3.0),
                ),
              ),
              initialValue: accountName,
              onChanged: (val) {
                setState(() => accountName = val);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Public Key :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            TextFormField(
              maxLines: null,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).buttonColor, width: 3.0),
                ),
              ),
              initialValue: publicKey,
              onChanged: (val) {
                setState(() => publicKey = val);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Private Key :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            TextFormField(
              maxLines: null,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).buttonColor, width: 3.0),
                ),
              ),
              initialValue: privateKey,
              onChanged: (val) {
                setState(() => privateKey = val);
              },
            ),
          ],
        ),
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
          child: widget.isNew ? Text('Create') : Text('Save'),
          color: Theme.of(context).buttonColor,
          onPressed: () {
            if (widget.isNew) {
              widget.onAdd(accountName, publicKey, privateKey);
            } else {
              widget.onEdit(id, accountName, publicKey, privateKey);
            }
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
