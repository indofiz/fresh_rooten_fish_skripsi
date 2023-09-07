import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../components/data_ikan_selar_como.dart';
import '../components/table_ikan_selar_como.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

class IkanSelarComo extends StatelessWidget {
  const IkanSelarComo({super.key});

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
            title: const Text('Ikan Selar Como (Hapau)'),
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
              child: Image.asset('assets/ikan/selar_como1.png'),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Secara Umum',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: dataSelarComo1),
            Html(data: dataSelarComo2),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Habitat Sebaran',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: habitatSebaran),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Perilaku',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: perilaku1),
            Html(data: perilaku2),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Nilai Ekonomi',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: nilaiEkonomi1),
            Html(data: nilaiEkonomi2),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Status Konservasi',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: statusKonservasi),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Klasifikasi',
              textAlign: TextAlign.start,
              style: title,
            ),
            const SizedBox(
              height: 8,
            ),
            Html(data: klasifikasi),
            const TableIkanSelarComo(),
          ],
        ),
      ),
    );
  }
}
