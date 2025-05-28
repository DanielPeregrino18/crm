import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final List<TextButton> buttons;
  const CustomMenu({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

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
