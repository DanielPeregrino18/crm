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
  const ExpandableCard({
    super.key,
    required this.title,
    required this.child,
    required this.expanded,
    required this.estatus,
    required this.onTap
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  ExpandableController controller = ExpandableController();
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: controller,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Card(
          color: Colors.white,
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                widget.title,
                Divider(height: 4),
                widget.child,
                Divider(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(50, 30),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        setState(() {
                          controller.toggle();
                        });
                      },
                      label: Text(
                        controller.expanded ? "Ocultar detalle" : "Ver detalle",
                        style: GoogleFonts.montserrat(
                          color: Colors.blue,
                          fontSize: 15.sp,
                        ),
                      ),
                      icon: Icon(
                        controller.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.blue,
                        size: 20.sp,
                      ),
                    ),
                    widget.estatus
                  ],
                ),
                Expandable(
                    collapsed: SizedBox(),
                    expanded: widget.expanded
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}