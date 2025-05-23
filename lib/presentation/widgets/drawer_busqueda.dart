import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerBusqueda extends StatelessWidget {
  final Map<String, Widget> tabBars;
  final String title;
  const DrawerBusqueda({super.key, required this.title, required this.tabBars});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 300.w,
        child: DefaultTabController(
          length: tabBars.length,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs:
                tabBars.keys
                    .map(
                      (e) => Tab(
                    child: FittedBox(
                      child: Text(
                        e,
                        style: GoogleFonts.montserrat(fontSize: 15.sp),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
              title: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 20.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              centerTitle: true,
            ),
            body: TabBarView(
              children: tabBars.entries.map((e) => e.value).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
