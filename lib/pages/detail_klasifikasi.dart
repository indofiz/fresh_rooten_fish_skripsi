import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/prediksi.dart';
import '../components/title_section.dart';
import '../theme/colors.dart';

class DetailKlasifikasi extends StatefulWidget {
  final String id;
  const DetailKlasifikasi({super.key, required this.id});

  @override
  State<DetailKlasifikasi> createState() => _DetailKlasifikasiState();
}

class _DetailKlasifikasiState extends State<DetailKlasifikasi> {
  List<Color> warna = [
    busuk,
    sangatBusuk,
    sangatSegar,
    segar,
    busuk,
    sangatBusuk,
    sangatSegar,
    segar
  ];

  var ikanSegar =
      'Ikan memilki banyak kandungan gizi esensial yang sangat bermanfaat bagi kesehatan dan kecerdasan. Ikan mengandung protein, karbohidrat, vitamin, mineral, asam lemak Omega 3, 6, 9 yang baik manfaat nya untuk tubuh manusia.';

  var ikanBusuk =
      'Ikan yang tidak segar atau membusuk berisiko membawa penyakit dan bisa membuat seseorang keracunan makanan. Sebabnya, daging ikan yang membusuk bisa jadi tempat berkembang biak bakteri.';

  List<Color> warnaCon = [
    busuk,
    sangatBusuk,
    sangatSegar,
    segar,
    busuk,
    sangatBusuk,
    sangatSegar,
    segar
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: FutureBuilder<Prediksi?>(
              future: readPrediksi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final hasil = snapshot.data;
                  return hasil == null
                      ? const Center(child: Text('Data tidak ada'))
                      : bodyHasil(hasil);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          bottomNavigationBar: bottomNavBar(),
        ),
      ),
    );
  }

  Future<Prediksi?> readPrediksi() async {
    final docPrediksi =
        FirebaseFirestore.instance.collection('prediksi').doc(widget.id);
    final snapshot = await docPrediksi.get();
    if (snapshot.exists) {
      return Prediksi.fromJson(snapshot.data()!);
    }
    return null;
  }

  Widget bodyHasil(Prediksi prediksi) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            const TitleSection(
              title: 'Detail Klasifikasi',
              subtitle: 'Berikut adalah detail identifikasi mata ikan.',
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(18)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 240,
                  minHeight: 240,
                  maxWidth: 260,
                  maxHeight: 260,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(prediksi.urlgambar, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                prediksi.prediksi[0]['label'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: warna[prediksi.prediksi[0]['index']],
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Jenis Ikan ${prediksi.prediksi[0]['jenis'].toString()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Text(
              "Confidence: ${prediksi.prediksi[0]['confidence'].toStringAsFixed(4)}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '${prediksi.tanggal} - ${prediksi.waktu} ',
              style: TextStyle(
                color: black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            infoSaja(prediksi),
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 24),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          backgroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
        ),
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Kembali',
          style: TextStyle(color: white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget infoSaja(Prediksi prediksi) {
    return Container(
      decoration: BoxDecoration(
          color: warnaCon[prediksi.prediksi[0]['index']].withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: black,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Sekilas Info",
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              prediksi.prediksi[0]['label'].toLowerCase().contains('segar')
                  ? ikanSegar
                  : ikanBusuk,
              style: TextStyle(color: black.withOpacity(0.8), fontSize: 13),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
