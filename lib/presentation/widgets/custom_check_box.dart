import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.theme,
    required this.value,
    required this.text,
  });

  final ColorScheme theme;

  final bool? value;

  final String text;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late final ColorScheme _theme;

  late bool _value;

  late final String _text;

  @override
  void initState() {
    _theme = widget.theme;
    _value = widget.value == null ? false : widget.value!;
    _text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 0,
      children: [
        Checkbox(
          checkColor: _theme.primary,
          fillColor: WidgetStatePropertyAll(Colors.transparent),
          value: _value,
          onChanged: (bool? value) {
            if (widget.value == null) {
              setState(() {
                _value = value!;
              });
            }
          },
        ),
        Text(_text),
      ],
    );
  }
}
