import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBoldNormal extends StatelessWidget {
  final String bold;
  final String normal;
  final Color boldColor;
  const TextBoldNormal({
    super.key,
    required this.bold,
    required this.normal,
    this.boldColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.montserrat(fontSize: 15.sp),
        children: [
          TextSpan(
            text: "$bold: ",
            style: TextStyle(fontWeight: FontWeight.bold, color: boldColor),
          ),
          TextSpan(text: normal),
        ],
      ),
    );
  }
}
