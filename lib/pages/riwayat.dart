import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fresh_rooten_fish_skripsi/components/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../components/no_data.dart';
import '../components/prediksi.dart';
import '../components/title_section.dart';
import '../theme/colors.dart';
import 'detail_klasifikasi.dart';

class Riwayat extends StatefulWidget {
  final String email;
  const Riwayat({super.key, required this.email});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  late bool _isLoading;
  bool hasInternet = false;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(
      const Duration(seconds: 4),
      () => {
        setState(() {
          _isLoading = false;
        })
      },
    );
    super.initState();
    // InternetConnectionChecker().onStatusChange.listen((status) {
    //   final hasInternet = status == InternetConnectionStatus.connected;
    //   setState(() => this.hasInternet = hasInternet);
    // });
  }

  Stream<List<Prediksi>> readPrediksi() => FirebaseFirestore.instance
      .collection('prediksi')
      .where('email', isEqualTo: widget.email)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Prediksi.fromJson(doc.data())).toList());

  Stream<QuerySnapshot> countPrediksi() => FirebaseFirestore.instance
      .collection('prediksi')
      .where('email', isEqualTo: widget.email)
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        const TitleSection(
          title: 'Riwayat Klasifikasi',
          subtitle: 'Berikut riwayat ikan diidentifikasi yang pernah dilakukan',
        ),
        const SizedBox(
          height: 12,
        ),
        //
        _isLoading
            ? const Text('Loading...')
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Total Data : '),
                    Expanded(
                      flex: 0,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: countPrediksi(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something wrong! ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final count = snapshot.data?.docs;
                              return Text(count?.length.toString() ?? '0');
                            } else {
                              return const Center(
                                child: Text('0'),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 12,
        ),
        _isLoading
            ? Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => const ShimmerCard(),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                    itemCount: 10),
              )
            : Expanded(
                child: StreamBuilder<List<Prediksi>>(
                    stream: readPrediksi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final prediks = snapshot.data;
                        return prediks == null || prediks.isEmpty
                            ? const NoData()
                            : SlidableAutoCloseBehavior(
                                closeWhenOpened: true,
                                child: ListView(
                                  children: prediks.map(buildPrediksi).toList(),
                                ),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
      ],
    );
  }

  Widget buildPrediksi(Prediksi prediksi) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              final docPrediksi = FirebaseFirestore.instance
                  .collection('prediksi')
                  .doc(prediksi.id);
              FirebaseStorage.instance.refFromURL(prediksi.urlgambar).delete();
              docPrediksi.delete();
            },
            backgroundColor: Colors.red,
            icon: Ionicons.trash,
            label: 'Hapus',
          )
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: border, width: 1),
            color: white,
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(prediksi.urlgambar, fit: BoxFit.cover)),
          ),
          title: Row(
            children: [
              Text(
                prediksi.prediksi[0]['label'].toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                " (${prediksi.prediksi[0]['jenis'].toString()})",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: prediksi.prediksi[0]['jenis'] == 'Kembung'
                      ? busuk
                      : sangatSegar,
                ),
              ),
            ],
          ),
          subtitle: Text('${prediksi.tanggal} - ${prediksi.waktu}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailKlasifikasi(id: prediksi.id)),
            );
          },
        ),
      ),
    );
  }
}
