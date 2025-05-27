import 'package:crm/presentation/widgets/custom_bottom_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/almacenes_grid.dart';
import 'package:flutter/material.dart';

class MenuAlmacenes extends StatelessWidget {
  const MenuAlmacenes({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return CustomBottomMenu(
      theme: theme,
      height: 220,
      title: 'Seleccionar Almacén',
      content: AlmacenesGrid(theme: theme),
    );
  }
}
