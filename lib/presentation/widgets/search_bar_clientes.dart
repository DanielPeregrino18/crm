import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarClientes extends StatelessWidget {
  const SearchBarClientes({
    Key? key,
    required this.hint,
    required this.actions,
    required this.inputController,
    required this.setIdCliente,
  }) : super(key: key);

  final String hint;

  final List<Widget> actions;

  final SearchController inputController;

  final Function(int id) setIdCliente;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return SizedBox(
      child: SearchAnchor.bar(
        isFullScreen: false,
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        barElevation: WidgetStatePropertyAll(4),
        barBackgroundColor: WidgetStatePropertyAll(theme.onPrimary),
        barLeading: Icon(Icons.search, color: theme.primary),
        barTrailing: actions.map((Widget widget) => widget).toList(),
        barHintText: hint,
        searchController: inputController,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        viewBackgroundColor: theme.onPrimary,

        suggestionsBuilder: (context, controller) {
          return [
            ListTile(
              onTap: () {
                controller.closeView("1. VISA CFSA");
                setIdCliente(1);
              },
              title: Text(
                "1. VISA CFSA",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARNES FINAS SAN ANDRES, S.A. DE C.V.",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                  Text(
                    "CFS881114KWA",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                setIdCliente(2);
              },
              title: Text(
                "1. VISA CFSA",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARNES FINAS SAN ANDRES, S.A. DE C.V.",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                  Text(
                    "CFS881114KWA",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                setIdCliente(3);
              },
              title: Text(
                "1. VISA CFSA",
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARNES FINAS SAN ANDRES, S.A. DE C.V.",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                  Text(
                    "CFS881114KWA",
                    style: GoogleFonts.montserrat(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
