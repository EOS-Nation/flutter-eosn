import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/pongs.dart';

class PongCard extends StatelessWidget {
  final List<Pongs> pongs;

  PongCard({this.pongs});
  @override
  Widget build(BuildContext context) {
    List<DataRow> dataRow = pongs
        .map((pong) => DataRow(
              cells: <DataCell>[
                DataCell(Text('key')),
                DataCell(Text(pong.key)),
              ],
            ))
        .toList();

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
      rows: dataRow,
    );
  }
}
