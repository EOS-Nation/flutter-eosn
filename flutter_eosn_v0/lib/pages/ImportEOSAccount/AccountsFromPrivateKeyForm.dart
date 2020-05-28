import 'package:eosdart_ecc/eosdart_ecc.dart';
import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/eosToast.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/services/EOSService.dart';

class AccountsFromPrivateKeyForm extends StatefulWidget {
  final Function displayAccountSelect;
  AccountsFromPrivateKeyForm(this.displayAccountSelect);
  @override
  _AccountsFromPrivateKeyFormState createState() =>
      _AccountsFromPrivateKeyFormState();
}

class _AccountsFromPrivateKeyFormState
    extends State<AccountsFromPrivateKeyForm> {
  String eosNetworkName;
  String privateKey;
  TextEditingController textController;
  EOSService eosService;
  @override
  void initState() {
    super.initState();
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

  void setEOSService(String eosNetworkName) {
    eosService =
        EOSService(EOSService.eosNetworks[eosNetworkName.toLowerCase()]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              Wrap(
                children: <Widget>[
                  DropdownButton<String>(
                    hint: Text('Select EOS Network'),
                    value: eosNetworkName,
                    items: EOSService.eosNetworks.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        eosNetworkName = val;
                      });
                    },
                  ),
                ],
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Import'),
                    color: Theme.of(context).buttonColor,
                    onPressed: () async {
                      EOSToast toast = EOSToast();
                      try {
                        if (eosNetworkName == null || eosNetworkName.isEmpty) {
                          toast.warningCenterShortToast(
                              'Please select a network');
                        } else if (textController.text.isEmpty) {
                          toast.warningCenterShortToast(
                              'Please enter a private key');
                        } else {
                          setEOSService(eosNetworkName);
                          List<WalletAccount> accounts = await eosService
                              .getAccountsFromPrivateKey(textController.text);
                          widget.displayAccountSelect(eosNetworkName, accounts);
                        }
                      } on InvalidKey catch (e) {
                        toast.errorCenterShortToast('Invalid private key');
                        print(e.toString());
                      } catch (e) {
                        toast.errorCenterShortToast(
                            'Error importing accounts with this private key');
                        print(e.toString());
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    child: Text('Clear'),
                    color: Theme.of(context).buttonColor,
                    onPressed: () {
                      textController.text = '';
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Demo private key'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp';
                },
              ),
              RaisedButton(
                child: Text('Demo private key'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5HzvYQBpkAXckTe7uovq68KCgB9CDJSQCYxCoqayYRdxDbcB5iD';
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
