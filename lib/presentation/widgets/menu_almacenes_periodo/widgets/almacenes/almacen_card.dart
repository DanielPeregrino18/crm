import 'package:flutter/material.dart';
import 'package:crm/domain/entities/almacen_ob.dart';

class AlmacenCard extends StatelessWidget {
  final AlmacenOB almacen;

  final Function(int id, String nombre) setAlmacen;

  const AlmacenCard({
    super.key,
    required this.almacen,
    required this.setAlmacen,
  });

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
