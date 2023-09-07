import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../components/data_ikan_kembung.dart';
import '../components/table_ikan_kembung.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

class IkanKembung extends StatelessWidget {
  const IkanKembung({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text('Ikan Kembung'),
          ),
          body: bodyMakan(),
        ),
      ),
    );
  }

  Widget bodyMakan() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              width: double.infinity,
              child: Image.asset('assets/ikan/kembung2.png'),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Secara Umum',
              textAlign: TextAlign.start,
              style: title,
            ),
            Html(data: dataKembung1),
            Html(data: dataKembung2),
            Html(data: dataKembung3),
            Html(data: dataKembung4),
            Html(data: dataKembung5),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Klasifikasi Ikan Kembung',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            const TableIkanKembung(),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Morpologi',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: morfologi1),
            Html(data: morfologi2),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Reproduksi',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: reproduksi1),
            Html(data: reproduksi2),
            Html(data: reproduksi3),
            Html(data: reproduksi4),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Habitat',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: habitat1),
            Html(data: habitat2),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Tingkah Laku',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: tingkahlaku),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Peran Di Perairan',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: peranikankembungdiperairan),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Manfaat Ikan',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: manfaatikankembung),
            Text(
              'Penulis',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: penulis),
          ],
        ),
      ),
    );
  }
}
