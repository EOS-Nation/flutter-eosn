import 'package:myapp/models/pongs.dart';

class Pings {
  final String uid;
  final String name;
  final String first;
  final String timestamps;
  final String trxId;
  final List<Pongs> pongs;

  Pings(
      {this.name,
      this.first,
      this.timestamps,
      this.pongs,
      this.trxId,
      this.uid});
}
