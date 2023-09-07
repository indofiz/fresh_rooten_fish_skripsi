import 'package:flutter/material.dart';

import '../theme/colors.dart';

class TableIkanSelarComo extends StatelessWidget {
  const TableIkanSelarComo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: Center(
        child: DataTable(
          columnSpacing: 100,
          columns: [
            DataColumn(
              label: Text(
                'Kingdom',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black.withOpacity(0.9)),
              ),
            ),
            DataColumn(
              label: Text(
                'Animalia',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: black.withOpacity(0.9)),
              ),
            ),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('Filum')),
              DataCell(Text('Chordata')),
            ]),
            DataRow(cells: [
              DataCell(Text('Kelas')),
              DataCell(Text('Actinopterygii')),
            ]),
            DataRow(cells: [
              DataCell(Text('Ordo')),
              DataCell(Text('Carangiformes')),
            ]),
            DataRow(cells: [
              DataCell(Text('Suku')),
              DataCell(Text('Carangidae')),
            ]),
            DataRow(cells: [
              DataCell(Text('Genus')),
              DataCell(Text('Atule')),
            ]),
            DataRow(cells: [
              DataCell(Text('Spesies')),
              DataCell(Text('Atule mate')),
            ]),
          ],
        ),
      ),
    );
  }
}
