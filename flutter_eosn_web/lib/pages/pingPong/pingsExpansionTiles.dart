import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/pings.dart';
import 'package:fluttereosnv0/models/pongs.dart';
import 'package:fluttereosnv0/pages/pingPong/pong.dart';

class PingsExpansionTiles extends StatelessWidget {
  final List<Pings> pings;
  final Function pushPong;

  PingsExpansionTiles({this.pings, this.pushPong});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: pings.length,
          itemBuilder: (context, index) {
            Pings ping = pings[index];
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
                        RaisedButton(
                          color: Theme.of(context).buttonColor,
                          child: Text('Pong'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pong(
                                        pushPong: pushPong,
                                        trxID: ping.trxId,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ]);
          }),
    );
  }
}
