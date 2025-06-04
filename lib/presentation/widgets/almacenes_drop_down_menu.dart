import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/config/styles/custom_drop_down_menu.dart';

class AlmacenesDropDownMenu extends ConsumerStatefulWidget {
  final Function(int)? setAlmacen;

  const AlmacenesDropDownMenu({super.key, this.setAlmacen});

  @override
  ConsumerState createState() => _AlmacenesDropDownMenuState();
}

class _AlmacenesDropDownMenuState extends ConsumerState<AlmacenesDropDownMenu> {
  CustomDropDownMenuStyle styles = CustomDropDownMenuStyle();

  late List<AlmacenOB> almacenesLDB;

  late AlmacenOB? almacenSeleccionado;

  @override
  void didChangeDependencies() {
    almacenesLDB = ref.watch(almacenesFiltradosProvider);
    almacenSeleccionado = almacenesLDB.first;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AlmacenOB>(
      value: almacenSeleccionado,
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
        setState(() {
          almacenSeleccionado = value;
          widget.setAlmacen!(
            almacenSeleccionado!.id_almacen,
          );
        });
      },
    );
  }
}
