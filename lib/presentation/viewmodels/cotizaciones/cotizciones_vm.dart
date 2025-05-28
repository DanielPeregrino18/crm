import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/data/models/cab_cotizacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final cotizacionVMProvider = StateProvider<CotizcionesVM>(
  (ref) => CotizcionesVM(ref.read(apiCabCotizacionProvider)),
);

class CotizcionesVM extends ChangeNotifier {
  //Busqueda Principal
  int idAlmacen = 0;
  SearchController clienteController = SearchController();
  int idCliente = 0;
  int idTipoFecha = 0;
  DateTime fechaInicial = DateTime.now();
  DateTime fechaFin = DateTime.now();
  ApiCabCotizaciones apiCabCotizaciones;
  List<CabCotizacion> cotizaciones = [];

  CotizcionesVM(this.apiCabCotizaciones);

  void clearInputCliente() async {
    clienteController.clear();
  }

  Future buscarCotizacionesRango() async{
    cotizaciones = await apiCabCotizaciones.getCabsCotizacionesRango(
      1,
      1,
      "15/05/2025",
      "23/05/2025",
      1,
      "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
      2,
      10,
    );
    print(cotizaciones.length);
    notifyListeners();
  }
}