import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/pings.dart';
import 'package:fluttereosnv0/pages/pingPong/ping.dart';
import 'package:fluttereosnv0/pages/pingPong/pingsExpansionTiles.dart';
import 'package:fluttereosnv0/services/auth.dart';
import 'package:fluttereosnv0/services/pingPongContract.dart';

class PingPong extends StatefulWidget {
  @override
  _PingPongState createState() => _PingPongState();
}

class _PingPongState extends State<PingPong> {
  PingPongContract _pingPongContract;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    _pingPongContract = PingPongContract(
      nodeURL: 'http://jungle2.cryptolions.io:80',
    );

    return FutureBuilder(
        future: _pingPongContract.getTableRows(),
        builder: (BuildContext context, AsyncSnapshot<List<Pings>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Loading();
            default:
              return Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    elevation: 0.0,
                    title: Text('EOS Dart'),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Theme.of(context).buttonColor,
                          child: Text(
                            'Sign Off',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  body: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Theme.of(context).buttonColor,
                            child: Text('Ping'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ping(
                                          pushPing: _pingPongContract.pushPing,
                                        )),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text('Clear'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Do you want to clear pings?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Clear'),
                                        onPressed: () {
                                          _pingPongContract.pushClear();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      snapshot.hasError
                          ? Text('Error: ${snapshot.error}',
                              style: TextStyle(fontSize: 20))
                          : PingsExpansionTiles(
                              pings: snapshot.data,
                              pushPong: _pingPongContract.pushPong,
                            )
                    ],
                  ));
          }
        });
  }
}
