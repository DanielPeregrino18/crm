import 'package:crm/data/models/tipo_fecha_model.dart';
import 'package:crm/presentation/widgets/custom_bottom_menu.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/tipo_fecha_drop_down_menu.dart';
import 'package:flutter/material.dart';

class MenuPeriodo extends StatelessWidget {
  const MenuPeriodo({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: theme.primary,
    );

    final List<TipoFecha> options = [
      TipoFecha(ID_TIPO_FECHA: 1, NOMBRE_TIPO_FECHA: 'Fecha de registro'),
      TipoFecha(ID_TIPO_FECHA: 2, NOMBRE_TIPO_FECHA: 'Fecha de movimiento'),
      TipoFecha(ID_TIPO_FECHA: 3, NOMBRE_TIPO_FECHA: 'Fecha de cancelación'),
      TipoFecha(ID_TIPO_FECHA: 4, NOMBRE_TIPO_FECHA: 'Fecha de O.C'),
      TipoFecha(
        ID_TIPO_FECHA: 5,
        NOMBRE_TIPO_FECHA: 'Fecha de inicio consigna',
      ),
      TipoFecha(ID_TIPO_FECHA: 6, NOMBRE_TIPO_FECHA: 'Fecha de fin consigna'),
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
              Text(
                'Tipo: ',
                style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Fecha Inicial: ',
                style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Fecha Fin: ',
                style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TipoFechaDropDownMenu(options: options),
              ),
              FechaButton(esPrimeraFecha: true),
              FechaButton(esPrimeraFecha: false),
            ],
          ),
        ],
      );
    }

    return CustomBottomMenu(
      height: 250,
      title: 'Seleccionar Periodo',
      content: content(),
    );
  }
}
