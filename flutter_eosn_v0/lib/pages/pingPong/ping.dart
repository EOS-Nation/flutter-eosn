import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/services/pingPongContract.dart';

class Ping extends StatefulWidget {
  final PingPongContract pingPongContract;
  Ping({this.pingPongContract});
  @override
  _PingState createState() => _PingState();
}

class _PingState extends State<Ping> {
  bool isLoading;
  String name;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    name = '';
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
              title: Text('Ping'),
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
                        hintText: "Name",
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
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Ping'),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await widget.pingPongContract.pushPing(name: name);
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
