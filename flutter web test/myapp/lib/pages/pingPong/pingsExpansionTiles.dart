import 'package:flutter/material.dart';
import 'package:myapp/models/pings.dart';
import 'package:myapp/models/pongs.dart';
import 'package:myapp/pages/pingPong/pong.dart';
import 'package:flutter/services.dart';
import 'package:dart_esr/dart_esr.dart' as esrDart;
import 'package:myapp/commons/eosToast.dart';

class PingsExpansionTiles extends StatefulWidget {
  final List<Pings> pings;
  final Function pushPong;

  PingsExpansionTiles({this.pings, this.pushPong});

  @override
  _PingsExpansionTilesState createState() => _PingsExpansionTilesState();
}

class _PingsExpansionTilesState extends State<PingsExpansionTiles> {
  var esr;
  String encodedRequest;

  @override
  void initState() {
    super.initState();
    this.initESR();
  }

  void initESR() async {
    esr = esrDart.EOSIOSigningrequest('https://jungle2.cryptolions.io', 'v1',
        chainName: esrDart.ChainName.EOS_JUNGLE2);
    encodedRequest = '';
  }

  Future<void> encodePong() async {
    var auth = <esrDart.Authorization>[
      esrDart.Authorization.fromJson(esrDart.ESRConstants.PlaceholderAuth)
    ];

    var data = <String, String>{'name': ''};

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
    return Expanded(
      child: ListView.builder(
          itemCount: widget.pings.length,
          itemBuilder: (context, index) {
            Pings ping = widget.pings[index];
            return ExpansionTile(
                title: Text(ping.name.isNotEmpty ? ping.name : ping.uid),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ping',
                              style: TextStyle(fontSize: 18),
                            )),
                        Row(
                          children: <Widget>[
                            Text('UID: '),
                            Text(ping.uid),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('First: '),
                            Text(ping.first.isNotEmpty
                                ? ping.first
                                : 'No pong yet'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Timestamps: '),
                            Text(ping.timestamps),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('TrxId: '),
                            Expanded(
                              child: Text(
                                ping.trxId,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pongs',
                              style: TextStyle(fontSize: 18),
                            )),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: ping.pongs.length,
                            itemBuilder: (context, index) {
                              Pongs pong = ping.pongs[index];
                              return Row(
                                children: <Widget>[
                                  Text('Key: '),
                                  Expanded(
                                    child: Text(
                                      pong.key,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              );
                            }),
                        Row(
                          children: [
                            RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text('Pong'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pong(
                                            pushPong: widget.pushPong,
                                            trxID: ping.trxId,
                                          )),
                                );
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              color: Theme.of(context).buttonColor,
                              child: Text('Pong ESR'),
                              onPressed: () async {
                                await encodePong();
                                return showDialog(
                                    context: context,
                                    child: AlertDialog(
                                        content: Row(
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
                                                      new ClipboardData(
                                                          text:
                                                              encodedRequest));
                                                  EOSToast()
                                                      .infoCenterShortToast(
                                                          'Copied to Clipboard');
                                                },
                                              )
                                            : SizedBox(),
                                      ],
                                    )));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]);
          }),
    );
  }
}
