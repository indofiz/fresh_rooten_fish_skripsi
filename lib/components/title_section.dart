import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: black, fontSize: 22, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: textFieldColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
