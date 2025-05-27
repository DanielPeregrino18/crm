import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final busquedaCotMovVMProvider = StateProvider<BusquedaCotMovVM>(
  (ref) => BusquedaCotMovVM(ref.read(apiCabCotizacionProvider)),
);

class BusquedaCotMovVM extends ChangeNotifier {
  TextEditingController movimientoController = TextEditingController();
  final ApiCabCotizaciones apiCabCotizaciones;
  BusquedaCotMovVM(this.apiCabCotizaciones);

  Future buscarCotizacionMov() async {
    var res = await apiCabCotizaciones.getCabCotMov(
      1,
      int.parse(movimientoController.text),
      "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
      2,
      10,
    );
  }
}
