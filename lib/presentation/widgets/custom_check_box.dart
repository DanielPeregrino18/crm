import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.text,
    required this.onChange,
    this.enable,
  });

  final bool? value;

  final String text;

  final Function(bool) onChange;
  final bool? enable;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Row(
      spacing: 0,
      children: [
        Checkbox(
          checkColor: theme.primary,
          fillColor: WidgetStatePropertyAll(Colors.transparent),
          value: widget.value,
          onChanged: (bool? value) {
            if (widget.enable??true && value!=null) {
              setState(() {
                 widget.onChange(value!);
              });
            }
          },
        ),
        Text(widget.text),
      ],
    );
  }
}
