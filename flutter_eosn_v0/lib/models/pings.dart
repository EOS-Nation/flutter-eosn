import 'package:fluttereosnv0/models/pongs.dart';

class Pings {
  final String uid;
  final String name;
  final String timestamps;
  final String trxId;
  final List<Pongs> pongs;

  Pings({this.name, this.timestamps, this.pongs, this.trxId, this.uid});
}
