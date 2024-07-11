import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fresh_rooten_fish_skripsi/components/title_section.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

import '../components/prediksi.dart';
import '../helper/image_classification_helper.dart';
import '../theme/colors.dart';

import 'package:image/image.dart' as img;

// import 'package:tflite/tflite.dart';

class HasilKlasifikasi extends StatefulWidget {
  final String? image;
  const HasilKlasifikasi({super.key, required this.image});

  @override
  State<HasilKlasifikasi> createState() => _HasilKlasifikasiState();
}

class _HasilKlasifikasiState extends State<HasilKlasifikasi> {
  UploadTask? uploadTask;

  ImageClassificationHelper? imageClassificationHelper;
  Map<String, double>? classification;
  Map<String, dynamic>? outputClassification;
  final gemini = Gemini.instance;

  List<Map>? hasilPrediksi;

  img.Image? fox;

  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

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
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();

    super.initState();
    // uploadImage(File(widget.image), hasilPrediksi?);
    geminiProses(widget.image);
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: loading
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 200, bottom: 0),
                        child: Column(
                          children: [
                            SizedBox(
                                width: 200,
                                child:
                                    Lottie.asset('assets/lottie/loader.json')),
                            const Center(
                              child: Text('Loading...'),
                            )
                          ],
                        ),
                      ),
                    )
                  : result != null
                      ? (widget.image != null &&
                              result != null &&
                              result!.toLowerCase().contains(RegExp('yes'), 0))
                          ? bodyHasil(hasilPrediksi)
                          : bodyHasilBukanIkan()
                      : Text('Kosong')),
          bottomNavigationBar: bottomNavBar(),
        ),
      ),
    );
  }

  Widget bodyHasil(data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            const TitleSection(
              title: 'Hasil Klasifikasi',
              subtitle:
                  'Berikut adalah hasil identifikasi mata ikan yang berdasarkan foto.',
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
                child: !loading
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            Image.file(File(widget.image!), fit: BoxFit.cover),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: data != null
                  ? Text(
                      data?[0]['label'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: warna[data?[0]['index']],
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    )
                  : Text('no hasil'),
            ),
            const SizedBox(
              height: 4,
            ),
            data != null
                ? Text(
                    "Jenis Ikan ${data?[0]['jenis']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  )
                : Text('No Data'),
            data != null
                ? Text(
                    "Confidence: ${data?[0]['confidence'].toStringAsFixed(4)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  )
                : Text('No Data'),
            const SizedBox(
              height: 32,
            ),
            infoSaja(data),
          ],
        ),
      ),
    );
  }

  Widget bodyHasilBukanIkan() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            const TitleSection(
              title: 'Hasil Klasifikasi',
              subtitle:
                  'Berikut adalah hasil identifikasi mata ikan yang berdasarkan foto.',
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
                child: !loading
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            Image.file(File(widget.image!), fit: BoxFit.cover),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
                child: Text(
              'BUKAN MATA IKAN!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: warna[0],
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            )),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 32,
            ),
            infoBukanMata(),
          ],
        ),
      ),
    );
  }

  Widget infoSaja(hasilData) {
    return Container(
      decoration: BoxDecoration(
          color: hasilData != null
              ? warnaCon[0].withOpacity(0.4)
              : warnaCon[hasilData?[0]['index']].withOpacity(0.4),
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
              hasilData?[0]['label'].toLowerCase().contains('segar')
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

  Widget infoBukanMata() {
    return Container(
      decoration: BoxDecoration(
          color: warnaCon[0].withOpacity(0.4),
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
              'Silahkan Kembali dan Ambil gambar baru, disarankan menggunakan gambar mata ikan agar aplikasi bisa mendeteksi kesegarannya',
              style: TextStyle(color: black.withOpacity(0.8), fontSize: 13),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      height: 86,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          buildProgress()
        ],
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: primary.withOpacity(0.3),
                    color: secondary,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 0,
            );
          }
        },
      );

  Future<void> geminiProses(String? image) async {
    if (image != null) {
      final imageData = File(image).readAsBytesSync();
      loading = true;
      gemini.textAndImage(
          text: 'YES or NO, is this fish eye?',
          images: [imageData]).then((value) {
        result = value?.content?.parts?.last.text;
        loading = false;
        processImage();
      });
    }
  }

  Future uploadImage(File image, List prediksi) async {
    // RESIZE IMAGE
    String fileName = image.path.split('/').last;
    final imageResize = img.decodeJpg(File(image.path).readAsBytesSync());
    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    final thumbnail = img.copyResize(imageResize!, width: 224);
    // Save the thumbnail to a jpeg file.
    final thumb_224 = img.encodeJpg(thumbnail);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    await File('$tempPath/$fileName').writeAsBytes(thumb_224);

    // UPLOAD PROCESS
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    String tanggal = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String waktu = DateFormat("HH:mm:ss").format(DateTime.now());
    DateTime createdAt = DateTime.now();
    final path = 'files/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(image);
    });
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // SIMPAN DATA
    final docPrediksi = FirebaseFirestore.instance.collection('prediksi').doc();

    final prediksiKirim = Prediksi(
        id: docPrediksi.id,
        email: email!,
        tanggal: tanggal,
        waktu: waktu,
        prediksi: prediksi,
        urlgambar: urlDownload,
        createdAt: createdAt);
    final json = prediksiKirim.toJson();

    await docPrediksi.set(json);
    setState(() {
      uploadTask = null;
    });
  }

  Future<void> processImage() async {
    if (!loading) {
      if (widget.image != null &&
          result != null &&
          result!.toLowerCase().contains(RegExp('yes'), 0)) {
        final imageData = File(widget.image!).readAsBytesSync();

        fox = img.decodeImage(imageData);
        classification = await imageClassificationHelper?.inferenceImage(fox!);
        if (classification != null) {
          final topClassification = getTopProbability(classification!);
          var label = topClassification.key;
          var confidence = topClassification.value;
          final info = label.split('-');

          Map<String, dynamic> predik = {
            'index': int.parse(info[0]),
            'jenis': info[1],
            'label': info[2],
            'confidence': confidence
          };

          List<Map> hasilPrediksis = [predik];
          uploadImage(File(widget.image!), hasilPrediksis);
          hasilPrediksi = hasilPrediksis;
        }
      }
    }
  }
}

MapEntry<String, double> getTopProbability(Map<String, double> labeledProb) {
  var pq = PriorityQueue<MapEntry<String, double>>(compare);
  pq.addAll(labeledProb.entries);

  return pq.first;
}

int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) {
    return -1;
  } else if (e1.value == e2.value) {
    return 0;
  } else {
    return 1;
  }
}

class Prediction {
  String label;
  double value;

  Prediction(this.label, this.value);
  @override
  String toString() {
    return '{ $label, $value }';
  }
}
