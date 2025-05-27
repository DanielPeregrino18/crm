import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({
    super.key,
    required this.theme,
    required this.height,
    required this.title,
    required this.content,
  });

  final ColorScheme theme;

  final double height;

  final String title;

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: theme.primary,
            ),
          ),
        ),
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: content,
          ),
        ),
      ),
    );
  }
}
