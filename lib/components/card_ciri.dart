import 'package:flutter/material.dart';

import '../pages/ikan_kembung.dart';
import '../pages/ikan_selar_como.dart';
import '../theme/colors.dart';

class CardCiri extends StatelessWidget {
  final String image;
  final String title;
  final int index;
  const CardCiri({
    super.key,
    required this.image,
    required this.title,
    required this.index,
  });

  static List page = [const IkanSelarComo(), const IkanKembung()];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page[index]),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: white,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              const EdgeInsets.only(top: 0, left: 32, right: 32, bottom: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Center(
              child: Column(
            children: [
              Image.asset(image),
              Text(
                title,
                style: TextStyle(color: black, fontWeight: FontWeight.w500),
              )
            ],
          )),
        ),
      ),
    );
  }
}
