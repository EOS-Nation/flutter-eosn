import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';

class Pong extends StatefulWidget {
  final Function pushPong;
  final String trxID;
  Pong({this.pushPong, this.trxID});
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> {
  bool isLoading;
  String account;
  String trxId;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    account = 'pacoeosnatio';
    trxId = widget.trxID;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              title: Text('Pong'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Account",
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).buttonColor, width: 3.0),
                        ),
                      ),
                      initialValue: account,
                      onChanged: (val) {
                        setState(() => account = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: new TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Transaction Id",
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).buttonColor, width: 3.0),
                        ),
                      ),
                      initialValue: trxId,
                      onChanged: (val) {
                        setState(() => trxId = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Pong'),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await widget.pushPong(account: account, trxId: trxId);
                          Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
