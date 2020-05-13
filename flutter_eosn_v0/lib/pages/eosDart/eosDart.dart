import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/pings.dart';
import 'package:fluttereosnv0/services/auth.dart';
import 'package:fluttereosnv0/services/pingPongContract.dart';

class EOSDartPage extends StatefulWidget {
  @override
  _EOSDartPageState createState() => _EOSDartPageState();
}

class _EOSDartPageState extends State<EOSDartPage> {
  PingPongContract _pingPongContract;
  String _trxId;

  @override
  void initState() {
    super.initState();
    _trxId = '';
  }

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
                  backgroundColor: Theme.of(context).primaryColorDark,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
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
                  body: Center(
                    child: Column(
                      children: <Widget>[
                        //Text(_trxId),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                child: Text('Ping'),
                                onPressed: () async {
                                  String trxId =
                                      await _pingPongContract.pushPing();
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                                child: Text('Pong'),
                                onPressed: () async {
                                  await _pingPongContract.pushPong(
                                      trxId:
                                          '00b68376e3b54823ff5f82cb0e16fe3beb0049db233955eda2c104a983a15061');
                                  setState(() {});
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
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
                                  Text('uid: ${snapshot.data.uid}',
                                      style: TextStyle(fontSize: 20)),
                                  Text('name: ${snapshot.data.name}',
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      'timestamps: ${snapshot.data.timestamps}',
                                      style: TextStyle(fontSize: 20)),
                                  Text('trxId: ${snapshot.data.trxId}',
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      'pongs: ${snapshot.data.pongs.toString()}',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              )
                      ],
                    ),
                  ));
          }
        });
  }
}
