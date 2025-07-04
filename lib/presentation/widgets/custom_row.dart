import 'dart:math';

import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String left;

  final Widget right;

  final double? height;

  const CustomRow({
    super.key,
    required this.left,
    required this.right,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
      height: height == null? min(50, 50) : height!,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: TextStyle(fontWeight: FontWeight.w600)),
          right,
        ],
      ),
    );
  }
}
