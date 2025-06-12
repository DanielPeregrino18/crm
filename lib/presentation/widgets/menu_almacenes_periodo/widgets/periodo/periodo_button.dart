import 'package:flutter/material.dart';
import 'package:crm/core/util/fecha.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/menu_periodo.dart';

class PeriodoButton extends StatefulWidget {
  final Function(int)? setTipoFecha;
  final Function(DateTime)? setFechaInicial;
  final Function(DateTime)? setFechaFinal;

  const PeriodoButton({
    super.key,
    this.setTipoFecha,
    this.setFechaInicial,
    this.setFechaFinal,
  });

  @override
  State<PeriodoButton> createState() => _PeriodoButtonState();
}

class _PeriodoButtonState extends State<PeriodoButton> {
  late int tipoFecha;
  late DateTime fechaInicial;
  late DateTime fechaFinal;
  final Fecha fecha = Fecha();

  @override
  void initState() {
    tipoFecha = 1;
    fechaInicial = fecha.ayerDateTime;
    fechaFinal = fecha.hoyDateTime;
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

  void actualizarTipoFecha(int tipoF) {
    widget.setTipoFecha?.call(tipoF);
    setState(() {
      tipoFecha = tipoF;
    });
  }

  void actualizarFechaInicial(DateTime fechaI) {
    widget.setFechaInicial?.call(fechaI);
    setState(() {
      fechaInicial = fechaI;
    });
  }

  void actualizarFechaFinal(DateTime fechaF) {
    widget.setFechaFinal?.call(fechaF);
    setState(() {
      fechaFinal = fechaF;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return TextButton.icon(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      label: Row(
        children: [
          Text(
            fecha.crearString(fechaInicial),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          Icon(Icons.arrow_right),
          Text(
            fecha.crearString(fechaFinal),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      icon: Icon(Icons.date_range_outlined, color: theme.primary, size: 24),
      onPressed: () {
        mostrarMenu(
          MenuPeriodo(
            setTipoFecha: actualizarTipoFecha,
            setFechaInicial: actualizarFechaInicial,
            setFechaFinal: actualizarFechaFinal,
            initialTipoFecha: tipoFecha,
            initialDateFechaInicial: fechaInicial,
            initialDateFechaFinal: fechaFinal,
          ),
        );
      },
    );
  }
}
