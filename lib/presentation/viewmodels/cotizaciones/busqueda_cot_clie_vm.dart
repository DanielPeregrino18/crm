import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion_cliente.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/busqueda_cot_mov_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final busquedaCotClieVMProvider = ChangeNotifierProvider.autoDispose<BusquedaCotClieVM>(
  (ref) => BusquedaCotClieVM(
    ref.read(formatterProvider),
    ref.read(apiCabCotizacionProvider),
    ref.read(busquedaCotMovVMProvider)
  ),
);

class BusquedaCotClieVM extends ChangeNotifier {
  int idAlmacen = 0;
  SearchController clienteController = SearchController();
  TextEditingController ordenCompraController = TextEditingController();
  TextEditingController folioController = TextEditingController();
  DateTime fechaInicial = DateTime.now();
  DateTime fechaFin = DateTime.now();
  DateFormat formatter;
  List<CabCotizacionCliente> cotizacionesCliente = [];

  ApiCabCotizaciones apiCabCotizaciones;
  BusquedaCotMovVM busquedaCotMovVM;
  BusquedaCotClieVM(this.formatter, this.apiCabCotizaciones, this.busquedaCotMovVM);

  void clearInputCliente() async {
    clienteController.clear();
  }
  void setFechaInicial(DateTime? date){
    if(date!=null){
      fechaInicial = date;
      notifyListeners();
    }
  }
  void setFechaFin(DateTime? date){
    if(date!=null){
      fechaFin = date;
      notifyListeners();
    }
  }
  Future<bool> buscarCotizaciones() async {
    cotizacionesCliente = await apiCabCotizaciones.getCabsCotCliente(
      idAlmacen,
      1,
      formatter.format(fechaInicial),
      formatter.format(fechaFin),
      folioController.text == "" ? 0 : int.parse(folioController.text),
      ordenCompraController.text,
      "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
      2,
      10,
    );
    return cotizacionesCliente.isNotEmpty;
  }

  Future<bool> buscarCotizacionMov({required int idMov}) {
    return busquedaCotMovVM.buscarCotizacionMov(idMov: idMov, idAlm: idAlmacen);
  }
}
