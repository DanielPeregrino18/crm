// import 'package:crm/domain/entities/almacen_ob.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class AlmacenCard extends ConsumerWidget {
//   final AlmacenOB almacen;
//
//   final Function(int id, String nombre) setAlmacen;
//
//   const AlmacenCard({
//     super.key,
//     required this.almacen,
//     required this.setAlmacen,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ColorScheme theme = Theme.of(context).colorScheme;
//
//     return Card(
//       elevation: 4,
//       color: theme.primary,
//       child: InkWell(
//         splashColor: theme.primary.withAlpha(90),
//         onTap: () {
//           setAlmacen(almacen.id_almacen, almacen.nombre);
//           Navigator.pop(context);
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Text(
//                 '${almacen.id_almacen}. ${almacen.nombre}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: theme.onPrimary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlmacenCard extends ConsumerStatefulWidget {
  final AlmacenOB almacen;

  final Function(int id, String nombre) setAlmacen;

  const AlmacenCard({
    super.key,
    required this.almacen,
    required this.setAlmacen,
  });

  @override
  ConsumerState<AlmacenCard> createState() => _AlmacenCardState();
}

class _AlmacenCardState extends ConsumerState<AlmacenCard> {
  late AlmacenOB almacen;

  late Function(int id, String nombre) setAlmacen;

  @override
  void initState() {
    almacen = widget.almacen;
    setAlmacen = widget.setAlmacen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      color: theme.primary,
      child: InkWell(
        splashColor: theme.primary.withAlpha(90),
        onTap: () {
          setAlmacen(almacen.id_almacen, almacen.nombre);
          setState(() {});
          Navigator.pop(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${almacen.id_almacen}. ${almacen.nombre}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
