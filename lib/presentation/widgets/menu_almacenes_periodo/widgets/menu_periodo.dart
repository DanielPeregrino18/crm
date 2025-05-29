import 'package:flutter/material.dart';
import 'package:crm/data/models/tipo_fecha_model.dart';
import 'package:crm/presentation/widgets/custom_bottom_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/tipo_fecha_drop_down_menu.dart';

class MenuPeriodo extends StatelessWidget {
  final Function(int tipoFecha) setTipoFecha;

  final Function(String fechaInicial) setFechaInicial;

  final Function(String fechaFinal) setFechaFinal;

  const MenuPeriodo({
    super.key,
    required this.setTipoFecha,
    required this.setFechaInicial,
    required this.setFechaFinal,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: theme.primary,
    );

    final List<TipoFecha> options = [
      TipoFecha(ID_TIPO_FECHA: 1, NOMBRE_TIPO_FECHA: 'Fecha registro'),
      TipoFecha(ID_TIPO_FECHA: 2, NOMBRE_TIPO_FECHA: 'Fecha movimiento'),
      TipoFecha(ID_TIPO_FECHA: 3, NOMBRE_TIPO_FECHA: 'Fecha cancelación'),
      TipoFecha(ID_TIPO_FECHA: 4, NOMBRE_TIPO_FECHA: 'Fecha orden compra'),
      TipoFecha(ID_TIPO_FECHA: 5, NOMBRE_TIPO_FECHA: 'Fecha inicio consigna'),
      TipoFecha(ID_TIPO_FECHA: 6, NOMBRE_TIPO_FECHA: 'Fecha fin consigna'),
    ];

    Widget content() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Tipo: ', style: textStyle),
              Text('Fecha Inicial: ', style: textStyle),
              Text('Fecha Fin: ', style: textStyle),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TipoFechaDropDownMenu(
                  options: options,
                  setTipoFecha: setTipoFecha,
                ),
              ),
              FechaButton(setFechaInicial: setFechaInicial),
              FechaButton(setFechaFinal: setFechaFinal),
            ],
          ),
        ],
      );
    }

    return CustomBottomMenu(
      height: 220,
      title: 'Seleccionar Periodo',
      content: content(),
    );
  }
}
