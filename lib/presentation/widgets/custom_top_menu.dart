import 'package:flutter/material.dart';

class CustomTopMenu extends StatelessWidget {
  final List<Widget> elements;
  const CustomTopMenu({super.key, required this.elements});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
      width: double.maxFinite,
      color: theme.primary.withAlpha(80),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Center(
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: elements.map((Widget element) => element).toList(),
        ),
      ),
    );
  }
}
