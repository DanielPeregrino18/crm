import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/data/models/cab_cotizacion_cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final busquedaCotClieVMProvider = StateProvider<BusquedaCotClieVM>(
  (ref) => BusquedaCotClieVM(
    ref.read(formatterProvider),
    ref.read(apiCabCotizacionProvider),
  ),
);

class BusquedaCotClieVM extends ChangeNotifier {
  SearchController clienteController = SearchController();
  TextEditingController ordenCompraController = TextEditingController();
  TextEditingController folioController = TextEditingController();
  DateTime fechaInicial = DateTime.now();
  DateTime fechaFin = DateTime.now();
  DateFormat formatter;
  List<CabCotizacionCliente> cotizacionesCliente = [];

  ApiCabCotizaciones apiCabCotizaciones;
  BusquedaCotClieVM(this.formatter, this.apiCabCotizaciones);

  void clearInputCliente() async {
    clienteController.clear();
  }

  Future<bool> buscarCotizaciones() async {
    cotizacionesCliente = await apiCabCotizaciones.GetCabsCotCliente(
      1,
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
}
