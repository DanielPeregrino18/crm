import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'almacen_card.dart';

class AlmacenesGrid extends ConsumerWidget {
  const AlmacenesGrid({super.key, required this.setAlmacen});

  final Function(int id, String nombre) setAlmacen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AlmacenOB> almacenes = ref.watch(almacenesFiltradosProvider);

    return GridView.builder(
      itemCount: almacenes.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return AlmacenCard(
          almacen: almacenes[index],
          setAlmacen: setAlmacen,
        );
      },
    );
  }
}
