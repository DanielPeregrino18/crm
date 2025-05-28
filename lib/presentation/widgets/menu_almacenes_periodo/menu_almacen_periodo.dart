import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/fecha_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/widgets/custom_top_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_almacenes.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_periodo.dart';

class MenuAlmacenPeriodo extends ConsumerStatefulWidget {
  final int idAlmacen;
  final String nombreAlmacen;
  final Function(int id, String nombre) setAlmacen;

  const MenuAlmacenPeriodo({
    super.key,
    required this.idAlmacen,
    required this.nombreAlmacen,
    required this.setAlmacen,
  });

  @override
  ConsumerState createState() => _MenuAlmacenPeriodoState();
}

class _MenuAlmacenPeriodoState extends ConsumerState<MenuAlmacenPeriodo> {
  late int _idAlmacen;
  late String _nombreAlmacen;

  late Function(int id, String nombre) _setAlmacen;

  @override
  void initState() {
    super.initState();
    ref.read(almacenesVMProvider).getAllAlmacenesLDB();
    _idAlmacen = widget.idAlmacen;
    _nombreAlmacen = widget.nombreAlmacen;
    _setAlmacen = widget.setAlmacen;
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
    final ColorScheme theme = Theme.of(context).colorScheme;

    final List<AlmacenOB> almacenesLDB =
        ref.watch(almacenesVMProvider).almacenesFiltrados;

    final fechaInicial = ref.watch(fechaInicialStringProvider);
    final fechaFinal = ref.watch(fechaFinalStringProvider);

    final List<TextButton> buttons = [
      // Almacén
      TextButton.icon(
        label: Row(
          children: [
            Text(
              almacenesLDB.isEmpty
                  ? 'Sin almacenes'
                  : '$_idAlmacen. $_nombreAlmacen',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        icon: Icon(Icons.location_on, color: theme.primary, size: 24),
        onPressed: () {
          if (almacenesLDB.isNotEmpty) {
            mostrarMenu(MenuAlmacenes(setAlmacen: _setAlmacen));
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
        icon: Icon(Icons.date_range, color: theme.primary, size: 24),
        onPressed: () {
          mostrarMenu(MenuPeriodo(theme: theme));
        },
      ),
    ];

    return CustomMenu(buttons: buttons);
  }
}
