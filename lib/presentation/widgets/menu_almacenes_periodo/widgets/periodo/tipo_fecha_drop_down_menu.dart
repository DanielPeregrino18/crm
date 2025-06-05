import 'package:flutter/material.dart';
import 'package:crm/data/models/tipo_fecha_model.dart';
import 'package:crm/config/styles/custom_drop_down_menu.dart';

class TipoFechaDropDownMenu extends StatefulWidget {
  final List<TipoFecha> options;
  final Function(int) setTipoFecha;
  final int? initialTipoFecha;

  const TipoFechaDropDownMenu({
    super.key,
    required this.options,
    required this.setTipoFecha,
    this.initialTipoFecha,
  });

  @override
  State<TipoFechaDropDownMenu> createState() => _TipoFechaDropDownMenuState();
}

class _TipoFechaDropDownMenuState extends State<TipoFechaDropDownMenu> {
  final CustomDropDownMenuStyle styles = CustomDropDownMenuStyle();

  late TipoFecha? tipoFechaSeleccionado =
      widget.options[widget.initialTipoFecha != null
          ? widget.initialTipoFecha! - 1
          : 0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TipoFecha>(
      value: tipoFechaSeleccionado,
      icon: styles.icon,
      iconEnabledColor: styles.iconEnabledColor,
      elevation: styles.elevation,
      style: styles.textStyle,
      items:
          widget.options.map<DropdownMenuItem<TipoFecha>>((TipoFecha value) {
            return DropdownMenuItem<TipoFecha>(
              value: value,
              child: Text(value.NOMBRE_TIPO_FECHA),
            );
          }).toList(),
      onChanged: (TipoFecha? value) {
        setState(() {
          tipoFechaSeleccionado = value;
        });
        widget.setTipoFecha(value!.ID_TIPO_FECHA);
      },
    );
  }
}
