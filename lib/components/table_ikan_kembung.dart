import 'package:flutter/material.dart';

import '../theme/colors.dart';

class TableIkanKembung extends StatelessWidget {
  const TableIkanKembung({super.key});

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
              DataCell(Text('Pisces')),
            ]),
            DataRow(cells: [
              DataCell(Text('Subkelas')),
              DataCell(Text('Teleostei')),
            ]),
            DataRow(cells: [
              DataCell(Text('Ordo')),
              DataCell(Text('Percomorpy')),
            ]),
            DataRow(cells: [
              DataCell(Text('Sub ordo')),
              DataCell(Text('Scombridae')),
            ]),
            DataRow(cells: [
              DataCell(Text('Famili')),
              DataCell(Text('Scombridae')),
            ]),
            DataRow(cells: [
              DataCell(Text('Genus')),
              DataCell(Text('Rastrelliger')),
            ]),
            DataRow(cells: [
              DataCell(Text('Spesies laki-laki')),
              DataCell(Text('Rastrelliger kanagurta')),
            ]),
            DataRow(cells: [
              DataCell(Text('Spesies perempuan')),
              DataCell(Text('Rastrelliger brachysoma')),
            ]),
            DataRow(cells: [
              DataCell(Text('Nama Umum')),
              DataCell(Text('Indian mackerel (Inggris), kembung (Indonesia)')),
            ]),
          ],
        ),
      ),
    );
  }
}
