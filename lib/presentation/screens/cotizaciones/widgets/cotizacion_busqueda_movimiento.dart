import 'package:crm/presentation/viewmodels/cotizaciones/busqueda_cot_mov_vm.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/almacenes_drop_down_menu.dart';
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
          AlmacenesDropDownMenu(
            setAlmacen: (int id) {
              busquedaCotMov.idAlmacen = id;
            },
          ),
          CustomTextField(
            label: "Movimiento",
            isEnabled: true,
            controller: busquedaCotMov.movimientoController,
          ),
          CustomButton(onPressed: () async {
            bool seEncontroCot = await busquedaCotMov.buscarCotizacionMov();
            if(seEncontroCot){
              context.go("/vercotizacion");
            }else{
              Fluttertoast.showToast(
                  msg: "No se encontro la Cotización ingresada.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  textColor: Colors.white,
                  fontSize: 18.0
              );
            }
          }, label: "Buscar")
        ],
      ),
    );
  }
}
