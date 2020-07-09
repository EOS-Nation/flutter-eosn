import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dart_esr/dart_esr.dart' as esrDart;
import 'package:myapp/commons/eosToast.dart';
import 'package:myapp/commons/loading.dart';

class Ping extends StatefulWidget {
  final Function pushPing;
  Ping({this.pushPing});
  @override
  _PingState createState() => _PingState();
}

class _PingState extends State<Ping> {
  bool isLoading;
  String name;
  var esr;
  String encodedRequest;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    name = '';
    this.initESR();
  }

  void initESR() async {
    esr = esrDart.EOSIOSigningrequest('https://jungle2.cryptolions.io', 'v1',
        chainName: esrDart.ChainName.EOS_JUNGLE2);
    encodedRequest = '';
  }

  Future<void> encodePing() async {
    var auth = <esrDart.Authorization>[
      esrDart.Authorization.fromJson(esrDart.ESRConstants.PlaceholderAuth)
    ];

    var data = <String, String>{'name': name};

    var action = esrDart.Action()
      ..account = 'eosnpingpong'
      ..name = 'ping'
      ..authorization = auth
      ..data = data;
    var temp = await esr.encodeAction(action);
    setState(() {
      encodedRequest = temp;
    });
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
                          await widget.pushPing(name: name);
                          Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('Ping ESR'),
                      onPressed: () {
                        encodePing();
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          encodedRequest,
                          overflow: TextOverflow.clip,
                        )),
                        encodedRequest.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () async {
                                  await Clipboard.setData(
                                      new ClipboardData(text: encodedRequest));
                                  EOSToast().infoCenterShortToast(
                                      'Copied to Clipboard');
                                },
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
