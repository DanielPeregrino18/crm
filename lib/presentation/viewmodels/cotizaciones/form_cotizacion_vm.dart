import 'dart:ffi';

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
  DateTime fechaInicioConsigna = DateTime.now();
  DateTime fechaFinConsigna = DateTime.now();
  TextEditingController campoAddendaController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();
  bool autorizar = false;
  bool ivaTotalRetenido = false;
  TextEditingController domicilioController = TextEditingController();
  TextEditingController coloniaController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController ciudadController = TextEditingController();
  TextEditingController codigoPController = TextEditingController();
  TextEditingController entreCallesController = TextEditingController();
  TextEditingController domicilioAtencionAContoller = TextEditingController();
  DateTime fechaEntrega = DateTime.now();
  TimeOfDay horaEntrega = TimeOfDay.now();
  double subtotal = 0.0;
  double  descTotal = 0.0;
  double iepsTotal = 0.0;
  double importeDescuento = 0.0;
  double ivaTotal = 0.0;
  double ivaRetenido = 0.0;
  double granTotal = 0.0;
  FormCotizacionVM(this.formatter);
  void met(){

  }
  
  String getFechaRegistro(){
    return formatter.format(fechaRegistro);
  }
  String getFechaOC(){
    return formatter.format(fechaOrdenCompra);
  }
  String getFechaInicioConsigna(){
    return formatter.format(fechaInicioConsigna);
  }
  String getfechaFinConsigna(){
    return formatter.format(fechaFinConsigna);
  }
  String getfechaEntrega(){
    return formatter.format(fechaEntrega);
  }
}