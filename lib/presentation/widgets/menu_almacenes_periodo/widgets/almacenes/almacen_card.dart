import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlmacenCard extends ConsumerWidget {
  const AlmacenCard({super.key, required this.almacen, required this.theme});

  final AlmacenOB almacen;

  final ColorScheme theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      color: theme.primary,
      child: InkWell(
        splashColor: theme.primary.withAlpha(90),
        onTap: () {
          ref
              .read(almacenSeleccionadoProvider.notifier)
              .seleccionarAlmacen(almacen);
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
