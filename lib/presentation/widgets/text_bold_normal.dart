import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class TextBoldNormal extends StatelessWidget {
  final String bold;
  final String normal;
  const TextBoldNormal({super.key, required this.bold, required this.normal});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.montserrat(fontSize: 15.sp),
        children: [
          TextSpan(
            text: "$bold: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: normal),
        ],
      ),
    );
  }
}
