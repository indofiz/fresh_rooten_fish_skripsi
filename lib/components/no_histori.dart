import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/colors.dart';

class NoHistori extends StatelessWidget {
  const NoHistori({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: 120,
          child: Lottie.asset('assets/lottie/no_history.json'),
        ),
        const SizedBox(
          height: 0,
        ),
        Text(
          'Belum Ada Data',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Silahkan lakukan klasifikasi gambar terlebih dahulu, jika belum paham silahkan menuju ke panduan.',
            style: TextStyle(
              color: black.withOpacity(0.4),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
