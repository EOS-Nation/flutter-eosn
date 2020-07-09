import 'package:flutter/material.dart';
import 'package:dart_esr/dart_esr.dart';
import 'package:flutter/services.dart';
import 'package:myapp/commons/eosToast.dart';

class ESR extends StatefulWidget {
  @override
  _ESRState createState() => _ESRState();
}

class _ESRState extends State<ESR> {
  var esr;
  String encodedRequest;

  @override
  void initState() {
    super.initState();
    esr = EOSIOSigningrequest('https://jungle2.cryptolions.io', 'v1',
        chainName: ChainName.EOS_JUNGLE2);
    encodedRequest = '';
  }

  void endcodeTransaction() async {
    var permission = IdentityPermission()
      ..actor = 'testname1111'
      ..permission = 'active';

    var identity = Identity()..identityPermission = permission;
    String callback = "https://callback.com";

    var temp = await esr.encodeIdentity(identity, callback);

    setState(() {
      encodedRequest = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0.0,
          title: Text('ESR'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () => endcodeTransaction(),
                color: Theme.of(context).buttonColor,
                child: Text('Encode Request'),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
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
                              EOSToast()
                                  .infoCenterShortToast('Copied to Clipboard');
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
