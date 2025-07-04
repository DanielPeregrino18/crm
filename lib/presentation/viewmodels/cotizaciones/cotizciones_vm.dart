import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/core/services/api_colecciones.dart';
import 'package:crm/data/models/cliente_modelo.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:crm/data/models/cotizaciones/det_cotizacion_mov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final cotizacionVMProvider = ChangeNotifierProvider<CotizcionesVM>(
  (ref) => CotizcionesVM(ref.read(apiCabCotizacionProvider), 
                                        ref.read(formatterProvider),
                                                  ref.read(apiColleccionesProvider)),
);

class CotizcionesVM extends ChangeNotifier {
  ApiCabCotizaciones apiCabCotizaciones;
  DateFormat formatter;
  //Busqueda Principal
  int idAlmacen = 0;
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
  ApiColecciones apiColecciones;
  FocusNode focusCliente = FocusNode();
  TextEditingController clienteController = TextEditingController();

  CotizcionesVM(this.apiCabCotizaciones, this.formatter, this.apiColecciones);

  void clearInputCliente() async {
    clienteController.clear();
  }

  Future buscarCotizacionesRango() async{
    cotizaciones = await apiCabCotizaciones.getCabsCotizacionesRango(
      idAlmacen,
      idTipoFecha,
      formatter.format(fechaInicial),
      formatter.format(fechaFin),
      idCliente,
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
  void setFechaInicial(DateTime fecha){
    fechaInicial = fecha;
  }
  void setFechaFin(DateTime fecha){
    fechaFin = fecha;
  }

  void setCliente(ClienteModelo cliente) {
    idCliente = cliente.idCliente;
    clienteController = TextEditingController(text: cliente.nombre);
    notifyListeners();
  }
}