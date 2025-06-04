import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarClientes extends StatefulWidget {
  const SearchBarClientes({
    super.key,
    required this.hint,
    required this.actions,
    required this.inputController,
    required this.setIdCliente,
    this.initialValue,
  });

  final String hint;
  final String? initialValue;

  final List<Widget> actions;

  final SearchController inputController;

  final Function(int id) setIdCliente;

  @override
  State<SearchBarClientes> createState() => _SearchBarClientesState();
}

class _SearchBarClientesState extends State<SearchBarClientes>
    with AfterLayoutMixin<SearchBarClientes> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    
    return SizedBox(
      child: SearchAnchor.bar(
        isFullScreen: false,
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        barElevation: WidgetStatePropertyAll(4),
        barBackgroundColor: WidgetStatePropertyAll(theme.onPrimary),
        barLeading: Icon(Icons.search, color: theme.primary),
        barTrailing: widget.actions.map((Widget widget) => widget).toList(),
        barHintText: widget.hint,
        searchController: widget.inputController,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        viewBackgroundColor: theme.onPrimary,
        suggestionsBuilder: (context, controller) {
          return [
            ListTile(
              onTap: () {
                controller.closeView("1. VISA CFSA");
                widget.setIdCliente(1);
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
                widget.setIdCliente(2);
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
                widget.setIdCliente(3);
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

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (widget.initialValue != null) {
      widget.inputController.openView();
      widget.inputController.closeView(widget.initialValue);
    }
  }
}
