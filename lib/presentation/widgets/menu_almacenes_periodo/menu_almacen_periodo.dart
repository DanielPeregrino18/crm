import 'package:crm/presentation/viewmodels/fecha_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/widgets/custom_top_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_almacenes.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_periodo.dart';

class MenuAlmacenPeriodo extends ConsumerStatefulWidget {
  const MenuAlmacenPeriodo({super.key, required this.theme});

  final ColorScheme theme;

  @override
  ConsumerState createState() => _MenuAlmacenPeriodoState();
}

class _MenuAlmacenPeriodoState extends ConsumerState<MenuAlmacenPeriodo> {
  late final ColorScheme _theme;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme;
    ref.read(almacenesVMProvider).getAllAlmacenesLDB();
  }

  void mostrarMenu(Widget menu) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return menu;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final almacenSeleccionado = ref.watch(almacenSeleccionadoProvider);
    final almacenesLDB =
        ref.watch(almacenesVMProvider.notifier).almacenesFiltrados;

    final fechaInicial = ref.watch(fechaInicialStringProvider);
    final fechaFinal = ref.watch(fechaFinalStringProvider);

    final List<TextButton> buttons = [
      // Almacén
      TextButton.icon(
        label: Row(
          children: [
            Text(
              almacenesLDB
                      .isEmpty // Hay almacenes en persistencia local?
                  ? 'Sin almacenes' // No hay almacenes en persistencia local
                  : almacenSeleccionado.value ==
                      null // Hay un almacén seleccionado?
                  ? '${almacenesLDB[0].id_almacen}. ${almacenesLDB[0].nombre}' // No lo hay: muestra el primero de la lista
                  : '${almacenSeleccionado.value?.id_almacen}. ${almacenSeleccionado.value?.nombre}', // Si hay: Lo muestra
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        icon: Icon(Icons.location_on, color: _theme.primary, size: 24),
        onPressed: () {
          if (almacenesLDB.isNotEmpty) {
            mostrarMenu(MenuAlmacenes(theme: _theme));
          }
        },
      ),
      // Fecha
      TextButton.icon(
        label: Row(
          children: [
            Text(
              '${fechaInicial.value}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            Icon(Icons.arrow_right),
            Text(
              '${fechaFinal.value}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        icon: Icon(Icons.date_range, color: _theme.primary, size: 24),
        onPressed: () {
          mostrarMenu(MenuPeriodo(theme: _theme));
        },
      ),
    ];

    return CustomMenu(theme: _theme, buttons: buttons);
  }
}
