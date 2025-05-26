import 'package:json_annotation/json_annotation.dart';

part 'cab_cotizacion.g.dart';
@JsonSerializable()
class CabCotizacion {

  int? RENGLON;
  int? ID_COTIZACION;
  String? CLIENTE;
  String? VENDEDOR;
  String? ESTATUS;
  double? TOTAL;
  double? PARIDAD;
  String? NOMBRE_ALMACEN;
  int? ID_ALMACEN;
  DateTime? FECHA;
  int? ID_VENDEDOR;
  String? NOMBRE_VENDEDOR;
  int? ID_CLIENTE;
  int? ID_CTE_FACTURA;
  double? DESCUENTO_GLOBAL;
  bool? ENTREGA_DOMICILIO;
  String? OBSERVACIONES;
  int? ID_NUMREFERENCIA;
  DateTime? FECHA_MOVIMIENTO;
  double? CARGO_FLETE;
  double? MANEJO_CUENTA;
  bool? MUESTRA_PUBLICO_GRAL;
  double? SUBTOTAL;
  double? IVA;
  double? DESCUENTO;
  int? DiasCredito;
  double? TipoCambio;
  String? Entrega;
  String? OrdenCompra;
  int? NUM_FACTURAS;
  DateTime? FECHA_CANCELACION;
  double? IVA_CTA;
  double? PORIVA_CTA;
  bool? Autorizada;
  int? Id_Usuario_Autoriza;
  bool? Req_Autorizacion;
  String? ATENCION;
  String? EntregarEnDomicilio;
  String? EntregarEnColonia;
  String? EntregarEnCP;
  String? EntregarEnCiudad;
  String? EntregarEnEstado;
  String? EntregarEnCalles;
  bool? ImprimirSinPrecios;
  String? Nombre;
  int? Id_Gravamen;
  String? CampoAddenda;
  DateTime? FECHA_INICIOC;
  DateTime? FECHA_FINC;
  DateTime? FECHA_OC;
  double? IEPS;
  bool? RETIENE_IVA;
  double? IVA_RETENIDO_TOTAL;

  CabCotizacion(this.RENGLON, this.ID_COTIZACION, this.CLIENTE, this.VENDEDOR,
      this.ESTATUS, this.TOTAL, this.PARIDAD, this.NOMBRE_ALMACEN,
      this.ID_ALMACEN, this.FECHA, this.ID_VENDEDOR, this.NOMBRE_VENDEDOR,
      this.ID_CLIENTE, this.ID_CTE_FACTURA, this.DESCUENTO_GLOBAL,
      this.ENTREGA_DOMICILIO, this.OBSERVACIONES, this.ID_NUMREFERENCIA,
      this.FECHA_MOVIMIENTO, this.CARGO_FLETE, this.MANEJO_CUENTA,
      this.MUESTRA_PUBLICO_GRAL, this.SUBTOTAL, this.IVA, this.DESCUENTO,
      this.DiasCredito, this.TipoCambio, this.Entrega, this.OrdenCompra,
      this.NUM_FACTURAS, this.FECHA_CANCELACION, this.IVA_CTA, this.PORIVA_CTA,
      this.Autorizada, this.Id_Usuario_Autoriza, this.Req_Autorizacion,
      this.ATENCION, this.EntregarEnDomicilio, this.EntregarEnColonia,
      this.EntregarEnCP, this.EntregarEnCiudad, this.EntregarEnEstado,
      this.EntregarEnCalles, this.ImprimirSinPrecios, this.Nombre,
      this.Id_Gravamen, this.CampoAddenda, this.FECHA_INICIOC, this.FECHA_FINC,
      this.FECHA_OC, this.IEPS, this.RETIENE_IVA, this.IVA_RETENIDO_TOTAL);

  factory CabCotizacion.fromJson(Map<String,dynamic> json) => _$CabCotizacionFromJson(json);
  Map<String, dynamic> toJson() => _$CabCotizacionToJson(this);
}