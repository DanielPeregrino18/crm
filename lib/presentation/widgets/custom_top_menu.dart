import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key, required this.theme, required this.buttons});

  final ColorScheme theme;

  final List<TextButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: theme.primary.withAlpha(80),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: buttons.map((TextButton option) => option).toList(),
        ),
      ),
    );
  }
}
