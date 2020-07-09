import 'package:eosdart_ecc/eosdart_ecc.dart';
import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/eosToast.dart';
import 'package:fluttereosnv0/models/EOSNetwork.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/services/EOSService.dart';

class AccountsFromPrivateKeyForm extends StatefulWidget {
  final Function addAccounts;
  final Function toggleSelectAccountPage;
  AccountsFromPrivateKeyForm(this.addAccounts, this.toggleSelectAccountPage);
  @override
  _AccountsFromPrivateKeyFormState createState() =>
      _AccountsFromPrivateKeyFormState();
}

class _AccountsFromPrivateKeyFormState
    extends State<AccountsFromPrivateKeyForm> {
  String privateKey;
  TextEditingController textController;
  EOSService eosService;
  @override
  void initState() {
    super.initState();
    privateKey = '';
    eosService = EOSService();
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

  void setEOSService(EOSNetwork eosNetwork) {
    eosService.updateEOSClient(eosNetwork);
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
                      var atLeastOneKeyFound = false;
                      for (var network in EOSService.eosNetworks.values) {
                        try {
                          if (textController.text.isEmpty) {
                            toast.warningCenterShortToast(
                                'Please enter a private key');
                            return;
                          } else {
                            setEOSService(network);
                            List<WalletAccount> accounts = await eosService
                                .getAccountsFromPrivateKey(textController.text);
                            widget.addAccounts(network.name, accounts);
                            atLeastOneKeyFound = true;
                          }
                        } on InvalidKey catch (e) {
                          toast.errorCenterShortToast('Invalid private key');
                          print(e.toString());
                        }
                      }
                      if (atLeastOneKeyFound) {
                        toast.errorCenterShortToast(
                            'Error importing accounts with this private key');
                      }
                      widget.toggleSelectAccountPage();
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
                child: Text('Demo 1 j2'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5Jcqx1c8n3HekLWXivopAWbTJwPuFhYZ4uUz9dob8Xeixzywjor';
                },
              ),
              RaisedButton(
                child: Text('Demo multiple j2'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5KMWVS1FJP5BMPUSQWDpGDAKdNCCL5H3z3Tqj6zePhtb3TvohtT';
                },
              ),
              RaisedButton(
                child: Text('Demo j3'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5JzyUkbXErq3W6BFdYoVXy3Y1n4cyyw8AW56TNpBQBLCN5u8a4K';
                },
              ),
              RaisedButton(
                child: Text('Demo both'),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  textController.text =
                      '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp';
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
