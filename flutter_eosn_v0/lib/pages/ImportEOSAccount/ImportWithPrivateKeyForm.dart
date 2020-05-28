import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/EOSNetwork.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/services/EOSService.dart';

class ImportWithPrivateKeyForm extends StatefulWidget {
  final Function displayAccountSelect;
  ImportWithPrivateKeyForm(this.displayAccountSelect);
  @override
  _ImportWithPrivateKeyFormState createState() =>
      _ImportWithPrivateKeyFormState();
}

class _ImportWithPrivateKeyFormState extends State<ImportWithPrivateKeyForm> {
  String privateKey;
  TextEditingController textController;
  EOSService eosService;
  @override
  void initState() {
    super.initState();
    eosService = EOSService(eosNetworks['jungle2']);
    privateKey = '';

    textController = TextEditingController();
    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Import Accounts',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: textController,
              maxLines: null,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter Private Key",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).buttonColor, width: 3.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text('Import'),
                color: Theme.of(context).buttonColor,
                onPressed: () async {
                  try {
                    String x =
                        '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp';
                    List<WalletAccount> accounts = await eosService
                        .getAccountsFromPrivateKey(textController.text);
                    widget.displayAccountSelect(accounts);
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text('Demo private key'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp';
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text('Demo private key'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5HzvYQBpkAXckTe7uovq68KCgB9CDJSQCYxCoqayYRdxDbcB5iD';
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
