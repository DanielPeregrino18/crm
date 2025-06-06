import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/data/models/cliente_modelo.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion_mov.dart';
import 'package:crm/data/models/vendedor_modelo.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/viewmodels/vendedor_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final formCotizacionVMProvider = ChangeNotifierProvider<FormCotizacionVM>(
  (ref) => FormCotizacionVM(ref.read(formatterProvider),
                                                                        ref.read(almacenesVMProvider)),
);

class FormCotizacionVM extends ChangeNotifier {
  DateFormat formatter;
  AlmacenesViewModel almacenesVM;
  int idAlmacen = 0;
  String almacenLabel = "0";
  int idClienteController = 0;
  TextEditingController vendedorController = TextEditingController();
  FocusNode focusVendedor = FocusNode();
  TextEditingController clienteController = TextEditingController();
  FocusNode focusCliente = FocusNode();
  String nombre = "";
  TextEditingController sucursalController = TextEditingController(text: "1.-CLIENTE PRUEBA",);
  TextEditingController direccionController = TextEditingController();
  int idListaPrecios = 1;
  int idMoneda = 1;
  DateTime fechaVigencia = DateTime.now();
  DateTime fechaRegistro = DateTime.now();
  DateTime fechaOrdenCompra = DateTime.now();
  TextEditingController noSerieController = TextEditingController();
  TextEditingController ordenCompraController = TextEditingController();
  TextEditingController procesadoController = TextEditingController();
  String cotizacionLabel = '0';
  String estatusLabel = 'NUEVO';
  TextEditingController rfcController = TextEditingController();
  TextEditingController plazoController = TextEditingController();
  TextEditingController descuentoController = TextEditingController();
  TextEditingController paridadController = TextEditingController(text: '1.0000',);
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
  TextEditingController atencionAContoller = TextEditingController();
  DateTime fechaEntrega = DateTime.now();
  TimeOfDay horaEntrega = TimeOfDay.now();
  double subtotal = 0.0;
  double descTotal = 0.0;
  double iepsTotal = 0.0;
  double importeDescuento = 0.0;
  double ivaTotal = 0.0;
  double ivaRetenido = 0.0;
  double granTotal = 0.0;
  FormCotizacionVM(this.formatter, this.almacenesVM);
  void met() {}

  String getFechaRegistro() {
    return formatter.format(fechaRegistro);
  }

  String getFechaOC() {
    return formatter.format(fechaOrdenCompra);
  }

  String getFechaInicioConsigna() {
    return formatter.format(fechaInicioConsigna);
  }

  String getfechaFinConsigna() {
    return formatter.format(fechaFinConsigna);
  }

  String getfechaEntrega() {
    return formatter.format(fechaEntrega);
  }

  String getfechaVigencia() {
    return formatter.format(fechaVigencia);
  }

  void setAlmacenLabel(String alm){
    almacenLabel = alm;
    notifyListeners();
  }

  void setFechaVigencia(DateTime? date){
    fechaVigencia = date ?? fechaVigencia;
    notifyListeners();
  }

  void setFechaOrdenCompra(DateTime? date){
    fechaOrdenCompra = date ?? fechaOrdenCompra;
    notifyListeners();
  }
  void setFechaInicioConsigna(DateTime? date){
    fechaInicioConsigna = date ?? fechaInicioConsigna;
    notifyListeners();
  }
  void setFechaFinConsigna(DateTime? date){
    fechaFinConsigna = date ?? fechaFinConsigna;
    notifyListeners();
  }
  void setFechaEntrega(DateTime? date){
    fechaEntrega = date ?? fechaEntrega;
    notifyListeners();
  }
  void setHoraEntrega(TimeOfDay? hora){
    horaEntrega = hora ?? horaEntrega;
    notifyListeners();
  }
  void setMoneda(int idMon){
    if(idMoneda != idMon){
      idMoneda = idMon;
      notifyListeners();
    }
  }
  void setAutorizar(bool valor){
    autorizar = valor;
    notifyListeners();
  }
  void setIvaTRetenido(bool valor){
    ivaTotalRetenido = valor;
    notifyListeners();
  }
  void setIdListaPrecios(int id){
    idListaPrecios = id;
    notifyListeners();
  }

  void setCliente(ClienteModelo cliente){
    clienteController = TextEditingController(text: cliente.nombre);
    notifyListeners();
  }

  void setVendedor(VendedorModelo vendedor){
    vendedorController = TextEditingController(text: vendedor.nombre);
    notifyListeners();
  }

  void setCabCotizacion(CabCotizacionMov cabCotizacionMov) {
    if(cabCotizacionMov.cabCotizacion!=null) {
      CabCotizacion cabCotizacion = cabCotizacionMov.cabCotizacion!;
      idAlmacen = cabCotizacion.ID_ALMACEN ?? idAlmacen;
      almacenLabel = almacenesVM.almacenes[idAlmacen].nombre;
      //todo asignar cliente al search bar
      nombre = cabCotizacion.Nombre??"";
      sucursalController = TextEditingController(text: '${cabCotizacion.ID_SUCURSAL_CTE}',);
      direccionController = TextEditingController(text: '${cabCotizacion.EntregarEnDomicilio}',);
      idListaPrecios = cabCotizacionMov.idListaPrecio!;
      fechaVigencia = cabCotizacion.VIGENCIA ?? fechaVigencia;
      fechaRegistro = cabCotizacion.FECHA ?? fechaRegistro;
      fechaOrdenCompra = cabCotizacion.FECHA_OC ?? fechaOrdenCompra;
      noSerieController = TextEditingController(text: cabCotizacionMov.noSerie ?? "");
      ordenCompraController = TextEditingController(text: cabCotizacion.OrdenCompra ?? "");
      procesadoController = TextEditingController(text: "${cabCotizacionMov.idPedidoProcesado??10}");
      cotizacionLabel = cabCotizacion.ID_COTIZACION != null ? "${cabCotizacion.ID_COTIZACION}" : "0";
      estatusLabel = cabCotizacion.ESTATUS ?? "";
      rfcController = TextEditingController(text: cabCotizacionMov.rfc??"");
      plazoController = TextEditingController(text: "${cabCotizacionMov.plazo??10}");
      descuentoController = TextEditingController(text: "${cabCotizacion.DESCUENTO}");
      idMoneda = cabCotizacionMov.moneda ?? 10;
      paridadController = TextEditingController(text: "${cabCotizacion.PARIDAD}");
      fechaInicioConsigna = cabCotizacion.FECHA_INICIOC ?? fechaInicioConsigna;
      fechaFinConsigna = cabCotizacion.FECHA_FINC ?? fechaFinConsigna;
      campoAddendaController = TextEditingController(text: cabCotizacion.CampoAddenda);
      observacionesController = TextEditingController(text: cabCotizacion.OBSERVACIONES);
      autorizar = cabCotizacion.Req_Autorizacion ?? false;
      ivaTotalRetenido = cabCotizacion.RETIENE_IVA ?? false;
      domicilioController = TextEditingController(text: cabCotizacion.EntregarEnDomicilio);
      coloniaController = TextEditingController(text: cabCotizacion.EntregarEnColonia);
      estadoController = TextEditingController(text: cabCotizacion.EntregarEnEstado);
      ciudadController = TextEditingController(text: cabCotizacion.EntregarEnCiudad);
      entreCallesController = TextEditingController(text: cabCotizacion.EntregarEnCalles);
      atencionAContoller = TextEditingController(text: cabCotizacion.ATENCION);
      fechaEntrega = cabCotizacion.FECHAENTREGA ?? fechaEntrega;
      horaEntrega = TimeOfDay.fromDateTime(fechaEntrega);
      subtotal = cabCotizacion.SUBTOTAL ?? 0;
      descTotal = cabCotizacion.DESCUENTO_GLOBAL ?? 0;
      iepsTotal = cabCotizacion.IEPS ?? 0;
      importeDescuento = subtotal - descTotal;
      ivaTotal = cabCotizacion.IVA ?? 0;
      ivaRetenido = cabCotizacion.IVA_RETENIDO_TOTAL ?? 0;
    }

  }

  void clearForm(){
    idAlmacen = 0;
    idClienteController = 0;
    clienteController.clear();
    nombre = "";
    vendedorController.clear();
    sucursalController.clear();
    direccionController.clear();
    idListaPrecios = 1;
    idMoneda = 1;
    fechaVigencia = DateTime.now();
    fechaRegistro = DateTime.now();
    fechaOrdenCompra = DateTime.now();
    noSerieController.clear();
    ordenCompraController.clear();
    procesadoController.clear();
    cotizacionLabel = '0';
    estatusLabel = 'NUEVO';
    rfcController.clear();
    plazoController.clear();
    descuentoController.clear();
    paridadController = TextEditingController(text: '1.0000',);
    fechaInicioConsigna = DateTime.now();
    fechaFinConsigna = DateTime.now();
    campoAddendaController.toString();
    observacionesController.clear();
    autorizar = false;
    ivaTotalRetenido = false;
    domicilioController.clear();
    coloniaController.clear();
    estadoController.clear();
    ciudadController.clear();
    codigoPController = TextEditingController();
    entreCallesController = TextEditingController();
    atencionAContoller = TextEditingController();
    fechaEntrega = DateTime.now();
    horaEntrega = TimeOfDay.now();
    subtotal = 0.0;
    descTotal = 0.0;
    iepsTotal = 0.0;
    importeDescuento = 0.0;
    ivaTotal = 0.0;
    ivaRetenido = 0.0;
    granTotal = 0.0;
  }
}
