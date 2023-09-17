import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/colors.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32,
          ),
          Container(
            padding: EdgeInsets.zero,
            width: 300,
            child: Lottie.asset('assets/lottie/no_data.json'),
          ),
          const SizedBox(
            height: 12,
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
          )
        ],
      ),
    );
  }
}
