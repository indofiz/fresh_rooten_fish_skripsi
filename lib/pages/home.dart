import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_rooten_fish_skripsi/pages/detail_klasifikasi.dart';
import 'package:fresh_rooten_fish_skripsi/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/card_ciri.dart';
import '../components/no_histori.dart';
import '../components/prediksi.dart';
import '../components/shimmer.dart';
import '../components/title_section.dart';
import '../theme/colors.dart';

class PageHome extends StatefulWidget {
  final String email;
  const PageHome({super.key, required this.email});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  late bool _isLoading;

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
  }

  Stream<List<Prediksi>> readPrediksi() => FirebaseFirestore.instance
      .collection('prediksi')
      .where('email', isEqualTo: widget.email)
      .orderBy('createdAt', descending: true)
      .limit(5)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Prediksi.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          welcomePage(),
          Flexible(child: ciriIkan()),
          _isLoading
              ? Flexible(
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => const ShimmerCard(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: 2),
                )
              : Flexible(
                  child: StreamBuilder<List<Prediksi>>(
                    stream: readPrediksi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final prediks = snapshot.data;
                        return prediks == null || prediks.isEmpty
                            ? const NoHistori()
                            : ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                children: prediks.map(buildPrediksi).toList(),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget ciriIkan() {
    return const Column(
      children: [
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: TitleSection(
            title: 'Ikan Apa Saja?',
            subtitle: 'Hanya jenis berikut yang bisa diidentifikasi',
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardCiri(
                image: 'assets/images/selar_como.png',
                title: 'Selar Como',
                index: 0),
            CardCiri(
              image: 'assets/images/kembung.png',
              title: 'Kembung',
              index: 1,
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: TitleSection(
            title: 'Riwayat Identifikasi',
            subtitle:
                'Berikut riwayat ikan diidentifikasi yang pernah dilakukan',
          ),
        ),
      ],
    );
  }

  Widget welcomePage() {
    return Container(
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ],
              ),
              IconButton(
                alignment: Alignment.centerRight,
                iconSize: 24,
                onPressed: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      backgroundColor: primary,
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool('isEmail', false);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'KELUAR & RESET EMAIL',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.settings),
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Aplikasi bisa digunakan untuk mendeteksi kesegaran ikan laut selar como (hapau) dan kembung.',
            style: TextStyle(color: white.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  Widget buildPrediksi(Prediksi prediksi) {
    // print(emailAwait);
    return Container(
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
              child: Image.network(prediksi.urlgambar, fit: BoxFit.cover),
            ),
          ),
          title: Text(
            prediksi.prediksi[0]['label'].toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text('${prediksi.tanggal} - ${prediksi.waktu}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailKlasifikasi(id: prediksi.id)),
            );
          }),
    );
  }
}
