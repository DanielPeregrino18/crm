import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:crm/data/models/cotizaciones/det_cotizacion_mov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final cotizacionVMProvider = StateProvider<CotizcionesVM>(
  (ref) => CotizcionesVM(ref.read(apiCabCotizacionProvider), ref.read(formatterProvider)),
);

class CotizcionesVM extends ChangeNotifier {
  ApiCabCotizaciones apiCabCotizaciones;
  DateFormat formatter;
  //Busqueda Principal
  int idAlmacen = 0;
  SearchController clienteController = SearchController();
  int idCliente = 0;
  int idTipoFecha = 1;
  DateTime fechaInicial = DateTime(
    DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
  );
  DateTime fechaFin = DateTime.now();

  List<CabCotizacion> cotizaciones = [];
  List<DetCotizacionMov> detallesCotizacion = [];

  CotizcionesVM(this.apiCabCotizaciones, this.formatter);

  void clearInputCliente() async {
    clienteController.clear();
  }

  Future buscarCotizacionesRango() async{
    cotizaciones = await apiCabCotizaciones.getCabsCotizacionesRango(
      idAlmacen,
      idTipoFecha,
      formatter.format(fechaInicial),
      formatter.format(fechaFin),
      1,
      "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
      2,
      10,
    );
    notifyListeners();
  }

  Future buscarDetalleCotizacion(int idCotizacion, int idAlm) async{
    detallesCotizacion = await apiCabCotizaciones.getDetCotMov(
        idAlm,
        idCotizacion,
        "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
        2,
        10
    );
    print(detallesCotizacion.length);
    notifyListeners();
  }
  void setFechaInicial(String fecha){
    fechaInicial = DateFormat('d/M/y').parse(fecha);
  }
  void setFechaFin(String fecha){
    fechaFin = DateFormat('d/M/y').parse(fecha);
  }
}