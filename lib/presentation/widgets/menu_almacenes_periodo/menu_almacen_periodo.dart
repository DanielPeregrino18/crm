import 'package:flutter/material.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/core/utils/fechas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/widgets/custom_top_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_almacenes.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/menu_periodo.dart';

class MenuAlmacenPeriodo extends ConsumerStatefulWidget {
  final Function(int, String)? setAlmacen;

  final Function(int)? setTipoFecha;

  final Function(String)? setFechaInicial;

  final Function(String)? setFechaFinal;

  const MenuAlmacenPeriodo({
    super.key,
    this.setAlmacen,
    this.setTipoFecha,
    this.setFechaInicial,
    this.setFechaFinal,
  });

  @override
  ConsumerState createState() => _MenuAlmacenPeriodoState();
}

class _MenuAlmacenPeriodoState extends ConsumerState<MenuAlmacenPeriodo> {
  late int idAlmacen;
  late String nombreAlmacen;
  late int tipoFecha;
  late String fechaInicial;
  late String fechaFinal;

  @override
  void initState() {
    super.initState();
    ref.read(almacenesVMProvider).getAllAlmacenesLDB();
    idAlmacen = 0;
    nombreAlmacen = 'TODOS';
    fechaInicial = Fechas().ayerString();
    fechaFinal = Fechas().hoyString();
  }

  void actualizarAlmacen(int id, String nombre) {
    setState(() {
      idAlmacen = id;
      nombreAlmacen = nombre;
    });
    widget.setAlmacen?.call(id, nombre);
  }

  void actualizarTipoFecha(int tipoF) {
    widget.setTipoFecha?.call(tipoF);
  }

  void actualizarFechaInicial(String fechaI) {
    setState(() {
      fechaInicial = fechaI;
    });
    widget.setFechaInicial?.call(fechaI);
  }

  void actualizarFechaFinal(String fechaF) {
    setState(() {
      fechaFinal = fechaF;
    });
    widget.setFechaFinal?.call(fechaF);
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

    final List<TextButton> buttons = [
      // Almacén
      TextButton.icon(
        label: Row(
          children: [
            Text(
              '$idAlmacen. $nombreAlmacen',
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
          almacenesLDB.isEmpty
              ? debugPrint(
                'No hay almacenes para mostrar',
              ) // Se puede agregar un indicador en pantalla
              : mostrarMenu(MenuAlmacenes(setAlmacen: actualizarAlmacen));
        },
      ),
      // Fecha
      TextButton.icon(
        label: Row(
          children: [
            Text(
              fechaInicial,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            Icon(Icons.arrow_right),
            Text(
              fechaFinal,
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
          mostrarMenu(
            MenuPeriodo(
              setTipoFecha: actualizarTipoFecha,
              setFechaInicial: actualizarFechaInicial,
              setFechaFinal: actualizarFechaFinal,
            ),
          );
        },
      ),
    ];

    // Menú tipo cintilla
    return CustomTopMenu(buttons: buttons);
  }
}
