import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/pings.dart';
import 'package:fluttereosnv0/models/pongs.dart';
import 'package:fluttereosnv0/pages/pingPong/ping.dart';
import 'package:fluttereosnv0/pages/pingPong/pong.dart';
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
        privateKeys: ["5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp"]);

    return FutureBuilder(
        future: _pingPongContract.getTableRow(),
        builder: (BuildContext context, AsyncSnapshot<Pings> snapshot) {
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
                      //Text(_trxId),
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
                                          pingPongContract: _pingPongContract,
                                        )),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Theme.of(context).buttonColor,
                            child: Text('Pong'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pong(
                                          pingPongContract: _pingPongContract,
                                          trxID: snapshot.data.trxId,
                                        )),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text('Clear'),
                              onPressed: () {
                                _pingPongContract.pushClear();
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      snapshot.hasError
                          ? Text('Error: ${snapshot.error}',
                              style: TextStyle(fontSize: 20))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('UID: ${snapshot.data.uid}',
                                    style: TextStyle(fontSize: 20)),
                                Text('NAME: ${snapshot.data.name}',
                                    style: TextStyle(fontSize: 20)),
                                Text('timestamps: ${snapshot.data.timestamps}',
                                    style: TextStyle(fontSize: 20)),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'TRXID: ',
                                      style: TextStyle(fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Flexible(
                                      child: Text(
                                        snapshot.data.trxId,
                                        style: TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      Text('Pongs', style: TextStyle(fontSize: 20)),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.pongs.length,
                        itemBuilder: (context, index) {
                          Pongs pong = snapshot.data.pongs[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'KEY: ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Flexible(
                                    child: Text(
                                      pong.key,
                                      style: TextStyle(fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Text('VALUE: ${pong.value}',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          );
                        },
                      ),
                    ],
                  ));
          }
        });
  }
}
