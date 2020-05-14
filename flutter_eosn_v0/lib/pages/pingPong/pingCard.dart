import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/pings.dart';

class PingCard extends StatelessWidget {
  final Pings ping;

  PingCard({this.ping});
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Key',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Value',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: [
        DataRow(
          cells: <DataCell>[
            DataCell(Text('UID')),
            DataCell(Text(ping.uid)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Name')),
            DataCell(Text(ping.name)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Timestamps')),
            DataCell(Text(ping.timestamps)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('TrxId')),
            DataCell(Text(
              ping.trxId,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
      ],
    );
  }
}
