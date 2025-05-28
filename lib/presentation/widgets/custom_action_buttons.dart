import 'package:flutter/material.dart';

class CustomActionButtons extends StatelessWidget {
  const CustomActionButtons({
    super.key,
    required this.theme,
    required this.buttons,
  });

  final ColorScheme theme;

  final List<FloatingActionButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttons.map((FloatingActionButton button) => button).toList(),
    );
  }
}
