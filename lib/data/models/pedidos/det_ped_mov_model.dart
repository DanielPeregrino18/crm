import 'package:json_annotation/json_annotation.dart';

part 'det_ped_mov_model.g.dart';

@JsonSerializable()
class DetPedMovModel {
  int? ID_ALMACEN;
  int? ID_PEDIDO;
  int? NO_RENGLON;
  int? ID_ARTICULO;
  String? UNIDAD;
  int? FACTOR_COMPRAVENTA;
  double? CANTIDAD;
  double? CANTIDAD_AUX;
  double? IMPORTE;
  double? DESCUENTO;
  double? IEPS;
  double? IVA;
  double? CANTIDAD_FACTURADA;
  double? CANTIDAD_FACT_AUX;
  String? SERIE;
  double? PorIVA;
  double? PorIEPS;
  double? Precio;
  double? Iva_retenido;
  int? ID_LISTA;
  String? DESCRIPCION;
  String? PRESENTACION;
  int? SURTIO;
  bool? SURTIDO;
  double? CANTIDAD_ORIGINAL;
  double? CANTIDAD_AUX_ORIG;
  DateTime? Fecha_Requerido;
  int? CANTIDAD_EMPACADA;
  int? NIVEL_CASCADA;
  double? CANT_MAX_CASCADA;
  String? REF_CASCADA;
  double? PRECIOLISTA;
  double? PORIVARET;
  bool? ES_PAQUETE;
  double? COSTO_ULTIMO_MN;
  double? COSTO_ULTIMO_ME;
  double? COSTO_PROM_MN;
  double? COSTO_PROM_ME;

  DetPedMovModel({
    required this.ID_ALMACEN,
    required this.ID_PEDIDO,
    required this.NO_RENGLON,
    required this.ID_ARTICULO,
    required this.UNIDAD,
    required this.FACTOR_COMPRAVENTA,
    required this.CANTIDAD,
    required this.CANTIDAD_AUX,
    required this.IMPORTE,
    required this.DESCUENTO,
    required this.IEPS,
    required this.IVA,
    required this.CANTIDAD_FACTURADA,
    required this.CANTIDAD_FACT_AUX,
    required this.SERIE,
    required this.PorIVA,
    required this.PorIEPS,
    required this.Precio,
    required this.Iva_retenido,
    required this.ID_LISTA,
    required this.DESCRIPCION,
    required this.PRESENTACION,
    required this.SURTIO,
    required this.SURTIDO,
    required this.CANTIDAD_ORIGINAL,
    required this.CANTIDAD_AUX_ORIG,
    required this.Fecha_Requerido,
    required this.CANTIDAD_EMPACADA,
    required this.NIVEL_CASCADA,
    required this.CANT_MAX_CASCADA,
    required this.REF_CASCADA,
    required this.PRECIOLISTA,
    required this.PORIVARET,
    required this.ES_PAQUETE,
    required this.COSTO_ULTIMO_MN,
    required this.COSTO_ULTIMO_ME,
    required this.COSTO_PROM_MN,
    required this.COSTO_PROM_ME,
  });

  factory DetPedMovModel.fromJson(Map<String, dynamic> json) =>
      _$DetPedMovModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetPedMovModelToJson(this);
}
