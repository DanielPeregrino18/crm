import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isEnabled;
  TextEditingController controller;
  CustomTextField({Key? key, required this.label, required this.isEnabled, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context).colorScheme;
    return TextFormField(
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
