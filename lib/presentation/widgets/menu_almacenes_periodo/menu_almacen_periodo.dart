import 'package:flutter/material.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/almacen_button.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/periodo_button.dart';
import 'package:crm/presentation/widgets/custom_top_menu.dart';

class MenuAlmacenPeriodo extends StatelessWidget {
  final Function(int, String)? setAlmacen;
  final Function(int)? setTipoFecha;
  final Function(DateTime)? setFechaInicial;
  final Function(DateTime)? setFechaFinal;

  const MenuAlmacenPeriodo({
    super.key,
    this.setAlmacen,
    this.setTipoFecha,
    this.setFechaInicial,
    this.setFechaFinal,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> elements = [
      // Almacén
      Flexible(
        flex: 1,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: AlmacenButton(setAlmacen: setAlmacen),
        ),
      ),
      // Periodo
      Flexible(
        flex: 1,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: PeriodoButton(
            setTipoFecha: setTipoFecha,
            setFechaInicial: setFechaInicial,
            setFechaFinal: setFechaFinal,
          ),
        ),
      ),
    ];

    // Menú tipo cintilla
    return CustomTopMenu(elements: elements);
  }
}
