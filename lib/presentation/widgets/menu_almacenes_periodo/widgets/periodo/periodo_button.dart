import 'package:flutter/material.dart';
import 'package:crm/core/utils/fechas.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/menu_periodo.dart';

class PeriodoButton extends StatefulWidget {
  final Function(int)? setTipoFecha;

  final Function(String)? setFechaInicial;

  final Function(String)? setFechaFinal;

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
  late String fechaInicial;
  late String fechaFinal;

  @override
  void initState() {
    fechaInicial = Fechas().ayerString();
    fechaFinal = Fechas().hoyString();
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
      icon: Icon(Icons.date_range_outlined, color: theme.primary, size: 24),
      onPressed: () {
        mostrarMenu(
          MenuPeriodo(
            setTipoFecha: actualizarTipoFecha,
            setFechaInicial: actualizarFechaInicial,
            setFechaFinal: actualizarFechaFinal,
          ),
        );
      },
    );
  }
}
