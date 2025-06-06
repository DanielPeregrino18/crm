import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final TextInputType textInputType;

  final List<TextInputFormatter> textInputFormatters;

  final bool isEnabled;

  final TextEditingController? controller;

  final dynamic initialValue;
  final FocusNode? focusNode;


  const CustomTextField({
    super.key,
    this.label = '',
    this.textInputType = TextInputType.text,
    this.textInputFormatters = const [],
    this.isEnabled = true,
    this.controller,
    this.initialValue,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    FocusNode focus = focusNode ?? FocusNode();

    return TextFormField(
      keyboardType: textInputType,
      focusNode: focus,
      autofocus: false,
      inputFormatters: textInputFormatters,
      controller: controller,
      onTapOutside: (event) {
        focus.unfocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: theme.primary.withAlpha(15),
        label: Text(label),
        floatingLabelStyle: TextStyle(fontSize: 20),
      ),
      enabled: isEnabled,
      initialValue: initialValue == null ? null : '$initialValue',
    );
  }
}
