import 'package:crm/config/styles/custom_drop_down_menu.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlmacenesDropDownMenu extends ConsumerWidget {
  const AlmacenesDropDownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = CustomDropDownMenuStyle();

    final almacenSeleccionado = ref.watch(almacenSeleccionadoProvider);
    final almacenesLDB =
        ref.watch(almacenesVMProvider.notifier).almacenesFiltrados;

    return DropdownButton<AlmacenOB>(
      value: almacenSeleccionado.value ?? almacenesLDB.first,
      icon: styles.icon,
      iconEnabledColor: styles.iconEnabledColor,
      elevation: styles.elevation,
      style: styles.textStyle,
      items:
          almacenesLDB.map<DropdownMenuItem<AlmacenOB>>((AlmacenOB value) {
            return DropdownMenuItem<AlmacenOB>(
              value: value,
              child: Text('${value.id_almacen}. ${value.nombre}'),
            );
          }).toList(),
      onChanged: (AlmacenOB? value) {
        ref
            .read(almacenSeleccionadoProvider.notifier)
            .seleccionarAlmacen(value!);
      },
    );
  }
}
