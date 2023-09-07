import 'package:flutter/material.dart';

import '../theme/colors.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(color: border.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: black.withOpacity(0.05)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 100,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: black.withOpacity(0.05),
                ),
              ),
              Container(
                height: 12,
                width: 150,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: black.withOpacity(0.05),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
