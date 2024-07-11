import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';

import 'pages/hasil_klasifikasi.dart';
import 'pages/home.dart';
import 'pages/riwayat.dart';
import 'theme/colors.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final ImagePicker _picker = ImagePicker();

  String? imagePath;
  // Iterable<MapEntry<String, double>>? singleClassification;

  // Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  void cleanResult() {
    imagePath = null;
    // result = null;
    // loading = true;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickImage(ImageSource type) async {
    cleanResult();
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: type,
      );
      File image = File(pickedFile!.path);
      _cropImage(image);
    } catch (error) {
      // ignore: avoid_print
      print("error: $error");
    }
  }

  Future<void> _cropImage(File pickedFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        )
      ],
    );

    if (croppedFile != null) {
      // String fileName = croppedFile.path.split('/').last;
      setState(() {
        imagePath = croppedFile.path;
        // print(imagePath);
        if (imagePath != null) {
          // _predict();
          // processImage();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HasilKlasifikasi(image: imagePath),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: bgColor,
            body: getBody(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Ambil Gambar:',
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 40),
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: (() {
                                  pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                }),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.camera,
                                      color: white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      'Kamera Handphone',
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 40),
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: (() {
                                  pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                }),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.images,
                                      color: white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      'Galeri Handphone',
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              tooltip: 'Ambil Gambar',
              child: Icon(
                Icons.camera_alt,
                color: white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: getFooter(),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [PageHome(email: widget.email), Riwayat(email: widget.email)],
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [Ionicons.home, Ionicons.time];
    return AnimatedBottomNavigationBar(
      height: 54,
      icons: iconItems,
      activeColor: primary,
      splashColor: white,
      inactiveColor: black.withOpacity(0.5),
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      rightCornerRadius: 8,
      leftCornerRadius: 8,
      iconSize: 24,
      activeIndex: pageIndex,
      onTap: (index) {
        setTabs(index);
      },
    );
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Anda yakin?'),
            content: const Text('Ingin keuar dari aplikasi'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(), // <-- SEE HERE
                child: const Text('Keluar'),
              ),
            ],
          ),
        )) ??
        false;
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
