import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/form_cotizacion_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final busquedaCotMovVMProvider = StateProvider<BusquedaCotMovVM>(
  (ref) => BusquedaCotMovVM(ref.read(apiCabCotizacionProvider),
                                                      ref.read(formCotizacionVMProvider)),
);

class BusquedaCotMovVM extends ChangeNotifier {
  TextEditingController movimientoController = TextEditingController();
  final ApiCabCotizaciones apiCabCotizaciones;
  final FormCotizacionVM formCotizacionVM;
  BusquedaCotMovVM(this.apiCabCotizaciones, this.formCotizacionVM);

  Future<bool> buscarCotizacionMov({int? idMov}) async {
    try {
      var res = await apiCabCotizaciones.getCabCotMov(
        1,
        idMov ?? int.parse(movimientoController.text),
        "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
        2,
        10,
      );
      formCotizacionVM.setCabCotizacion(res);
      return true;
    } catch (e){
      return false;
    }
  }
}
