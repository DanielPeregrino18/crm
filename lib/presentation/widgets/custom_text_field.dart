import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final TextInputType textInputType;

  final List<TextInputFormatter> textInputFormatters;

  final bool isEnabled;

  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.textInputType = TextInputType.text,
    this.textInputFormatters = const [],
    required this.isEnabled,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      keyboardType: textInputType,
      inputFormatters: textInputFormatters,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: theme.primary.withAlpha(15),
        label: Text(label),
        floatingLabelStyle: TextStyle(fontSize: 20),
      ),
      enabled: isEnabled,
    );
  }
}
