import 'package:crm/config/DI/dependencias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final formCotizacionVMProvider = StateProvider<FormCotizacionVM>((ref) =>
                    FormCotizacionVM(ref.read(formatterProvider)),);

class FormCotizacionVM extends ChangeNotifier {
  
  DateFormat formatter;
  int idAlmacen = 0;
  int idClienteController = 0;
  SearchController clienteController =  SearchController();
  int idVendedorController = 0;
  SearchController vendedorController =  SearchController();
  TextEditingController sucursalController = TextEditingController(text: "1.-CLIENTE PRUEBA");
  TextEditingController atencionAController = TextEditingController();
  TextEditingController  direccionController = TextEditingController();
  DateTime fechaRegistro = DateTime.now();
  DateTime fechaOrdenCompra = DateTime.now();
  TextEditingController noSerieController = TextEditingController();
  TextEditingController ordenCompraController = TextEditingController();
  String pedidoLabel = '0';
  String estatusLabel = 'Nuevo';
  TextEditingController rfcController = TextEditingController();
  TextEditingController plazoController = TextEditingController();
  TextEditingController descuentoController = TextEditingController();
  TextEditingController paridadController = TextEditingController(text: '1.0000');
  
  FormCotizacionVM(this.formatter);
  void met(){

  }
  
  String getFechaRegistro(){
    return formatter.format(fechaRegistro);
  }
  String getFechaOC(){
    return formatter.format(fechaOrdenCompra);
  }
}