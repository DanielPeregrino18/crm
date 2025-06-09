import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final TextInputType textInputType;

  final List<TextInputFormatter> textInputFormatters;

  bool isEnabled;

  final TextEditingController? controller;

  final dynamic initialValue;
  final FocusNode? focusNode;
  final Function()? onClean;
  CustomTextField({
    super.key,
    this.label = '',
    this.textInputType = TextInputType.text,
    this.textInputFormatters = const [],
    this.isEnabled = true,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.onClean
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
        suffixIcon: controller != null ? InkWell(
          onTap: (){
            controller!.clear();
            if(onClean!=null){ onClean!();}
            },
          child: Icon(Icons.highlight_remove_rounded, color: theme.primary,),
        ): null,
      ),
      enabled: isEnabled,
      initialValue: initialValue == null ? null : '$initialValue',
    );
  }
}
