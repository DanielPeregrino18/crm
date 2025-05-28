import 'package:crm/presentation/widgets/custom_bottom_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/almacenes_grid.dart';
import 'package:flutter/material.dart';

class MenuAlmacenes extends StatelessWidget {
  final Function(int id, String nombre) setAlmacen;
  const MenuAlmacenes({super.key, required this.setAlmacen});

  @override
  Widget build(BuildContext context) {
    return CustomBottomMenu(
      height: 220,
      title: 'Seleccionar Almacén',
      content: AlmacenesGrid(setAlmacen: setAlmacen),
    );
  }
}
