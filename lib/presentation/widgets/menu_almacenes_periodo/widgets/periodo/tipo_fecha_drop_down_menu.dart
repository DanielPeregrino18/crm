import 'package:crm/config/styles/custom_drop_down_menu.dart';
import 'package:crm/data/models/tipo_fecha_model.dart';
import 'package:crm/presentation/viewmodels/fecha_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TipoFechaDropDownMenu extends ConsumerWidget {
  const TipoFechaDropDownMenu({super.key, required this.options});

  final List<TipoFecha> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = CustomDropDownMenuStyle();

    final tipoFechaSeleccionado = ref.watch(tipoFechaSeleccionadoProvider);

    return DropdownButton<TipoFecha>(
      value: tipoFechaSeleccionado.value ?? options.first,
      icon: styles.icon,
      iconEnabledColor: styles.iconEnabledColor,
      elevation: styles.elevation,
      style: styles.textStyle,
      items:
          options.map<DropdownMenuItem<TipoFecha>>((TipoFecha value) {
            return DropdownMenuItem<TipoFecha>(
              value: value,
              child: Text(value.NOMBRE_TIPO_FECHA),
            );
          }).toList(),
      onChanged: (TipoFecha? value) {
        ref
            .read(tipoFechaSeleccionadoProvider.notifier)
            .seleccionarTipoFecha(value!);
      },
    );
  }
}
