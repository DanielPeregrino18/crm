import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/menu_almacenes.dart';

class AlmacenButton extends ConsumerStatefulWidget {
  final Function(int, String)? setAlmacen;
  final int? initialValueIdAlmacen;

  const AlmacenButton({super.key, this.setAlmacen, this.initialValueIdAlmacen});

  @override
  ConsumerState<AlmacenButton> createState() => _AlmacenButtonState();
}

class _AlmacenButtonState extends ConsumerState<AlmacenButton> {
  late int idAlmacen;
  late String nombreAlmacen;
  late AlmacenOB? initialValueAlmacen;

  AlmacenOB? searchInitialValueAlmacen(int idAlmacen) {
    return ref
        .read(almacenesVMProvider)
        .almacenes
        .firstWhereOrNull((almacen) => almacen.id_almacen == idAlmacen);
  }

  @override
  void initState() {
    idAlmacen = widget.initialValueIdAlmacen ?? 0;
    ref.read(almacenesVMProvider).getAllAlmacenesLDB();

    if (widget.initialValueIdAlmacen != null) {
      initialValueAlmacen = searchInitialValueAlmacen(idAlmacen);
      nombreAlmacen =
          initialValueAlmacen != null
              ? initialValueAlmacen!.nombre
              : 'Almacén no guardado';
    } else {
      nombreAlmacen = 'TODOS';
    }

    super.initState();
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

  void actualizarAlmacen(int id, String nombre) {
    setState(() {
      idAlmacen = id;
      nombreAlmacen =
          nombre.length > 15 ? '${nombre.substring(0, 15)}...' : nombre;
    });
    widget.setAlmacen?.call(id, nombre);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final List<AlmacenOB> almacenesLDB =
        ref.watch(almacenesVMProvider).almacenesFiltrados;

    return TextButton.icon(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
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
      icon: Icon(Icons.storefront, color: theme.primary, size: 24),
      onPressed: () {
        almacenesLDB.isEmpty
            ? debugPrint(
              'No hay almacenes para mostrar',
            ) // Se puede agregar un indicador en pantalla
            : mostrarMenu(MenuAlmacenes(setAlmacen: actualizarAlmacen));
      },
    );
  }
}
