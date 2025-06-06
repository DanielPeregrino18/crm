import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'custom_text_field.dart';

class CustomSearchBar<T> extends StatelessWidget {
  CustomSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.itemBuilder,
    required this.sugerencias,
    required this.onSelect,
    required this.label,
    this.isEnabled = true
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget Function(BuildContext context, T value) itemBuilder;
  final Function(T value) onSelect;
  final String label;
  bool? isEnabled;
  final List<T> Function(String search) sugerencias;
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      controller: controller,
      focusNode: focusNode,
      hideOnUnfocus: true,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return CustomTextField(
          isEnabled: isEnabled!,
          controller: controller,
          focusNode: focusNode,
          label: label,
        );
      },
      itemBuilder: (context, value) {
        return itemBuilder(context, value);
      },
      onSelected: (value) {
        focusNode.unfocus();
        onSelect(value);
      },
      suggestionsCallback: (search) {
        return sugerencias(search);
      },
    );
  }
}
