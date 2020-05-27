import 'package:eosdart/eosdart.dart';
import 'package:fluttereosnv0/models/pings.dart';
import 'package:fluttereosnv0/models/pongs.dart';
import 'package:fluttereosnv0/services/walletManager.dart';

class PingPongContract {
  String nodeURL;
  String nodeVersion;
  List<String> privateKeys;
  WalletManager _walletManager;
  EOSClient _client;

  List<Authorization> _auth = [
    Authorization()
      ..actor = 'pacoeosnatio'
      ..permission = 'active'
  ];

  PingPongContract({this.nodeURL, this.nodeVersion = 'v1'}) {
    _client = EOSClient(nodeURL, nodeVersion);
    this.setClientPrivatekey();
  }

  void setClientPrivatekey() async {
    this._walletManager = await WalletManager.create();
    String pk = _walletManager.currentAccount.privateKey;
    this._client.privateKeys = [pk];
  }

  Pings pingFromTableRow(Map<String, dynamic> row) {
    List<Pongs> pongs = [];
    if (row['pongs'] is List<dynamic>) {
      for (var pong in row['pongs']) {
        pongs.add(Pongs(key: pong['key'], value: pong['value']));
      }
    }
    return Pings(
      uid: row['uid'],
      name: row['name'],
      first: row['first'],
      timestamps: row['timestamp'],
      pongs: pongs,
      trxId: row['trx_id'],
    );
  }

  Future<List<Pings>> getTableRows() async {
    try {
      dynamic table =
          await _client.getTableRows('eosnpingpong', 'eosnpingpong', 'pings');
      List<Pings> pings = [];
      for (var row in table) {
        pings.add(pingFromTableRow(row));
      }
      return pings;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<Pings> getTableRow() async {
    try {
      dynamic row =
          await _client.getTableRow('eosnpingpong', 'eosnpingpong', 'pings');
      return pingFromTableRow(row);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<String> pushPing({String name = ''}) async {
    try {
      Map data = {
        'name': name,
      };

      List<Action> actions = [
        Action()
          ..account = 'eosnpingpong'
          ..name = 'ping'
          ..authorization = _auth
          ..data = data
      ];

      Transaction transaction = Transaction()..actions = actions;

      dynamic trx = await _client.pushTransaction(transaction);
      return trx.toString();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<String> pushPong({String account = '', String trxId = ''}) async {
    try {
      Map data = {
        'account': account,
        'trx_id': trxId,
      };

      List<Action> actions = [
        Action()
          ..account = 'eosnpingpong'
          ..name = 'pong'
          ..authorization = _auth
          ..data = data
      ];

      Transaction transaction = Transaction()..actions = actions;
      dynamic trx = await _client.pushTransaction(transaction);

      return trx.toString();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<String> pushClear() async {
    try {
      List<Action> actions = [
        Action()
          ..account = 'eosnpingpong'
          ..name = 'clear'
          ..authorization = _auth
      ];

      Transaction transaction = Transaction()..actions = actions;

      dynamic trx = await _client.pushTransaction(transaction);
      return trx.toString();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
