import 'package:crm/presentation/viewmodels/cotizaciones/busqueda_cot_mov_vm.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/cotizciones_vm.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/custom_text_field.dart';

class CotizacionBusquedaMovimiento extends ConsumerWidget {
  const CotizacionBusquedaMovimiento({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busquedaCotMov = ref.watch(busquedaCotMovVMProvider);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          CustomTextField(
            label: "Movimiento",
            isEnabled: true,
            controller: busquedaCotMov.movimientoController,
          ),
          CustomButton(onPressed: (){
            busquedaCotMov.buscarCotizacionMov();
          }, label: "Buscar")
        ],
      ),
    );
  }
}
