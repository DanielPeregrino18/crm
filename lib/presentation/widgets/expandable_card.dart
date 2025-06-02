import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableCard extends StatefulWidget {
  final Widget title;
  final Widget child;
  final Widget expanded;
  final Widget estatus;
  final Function onTap;
  Future<void> Function()? onOpenDetalles;
  ExpandableCard({
    super.key,
    required this.title,
    required this.child,
    required this.expanded,
    required this.estatus,
    required this.onTap,
    this.onOpenDetalles
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  ExpandableController controller = ExpandableController();
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return ExpandableNotifier(
      controller: controller,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Card(
          color: theme.onPrimary,
          elevation: 4,
          shadowColor: theme.primary.withAlpha(60),
          margin: EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                widget.title,
                Divider(height: 8, color: theme.primary.withAlpha(60)),
                widget.child,
                Divider(height: 8, color: theme.primary.withAlpha(60)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(50, 30),
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () async {
                        if(widget.onOpenDetalles != null && !controller.expanded) {
                          await widget.onOpenDetalles!();
                        }
                        setState(() {
                          controller.toggle();
                        });
                      },
                      label: Text(
                        controller.expanded ? "Ocultar detalle" : "Ver detalle",
                        style: GoogleFonts.montserrat(
                          color: theme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      icon: Icon(
                        controller.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: theme.primary,
                        size: 20.sp,
                      ),
                    ),
                    widget.estatus,
                  ],
                ),
                Expandable(collapsed: SizedBox(), expanded: widget.expanded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
