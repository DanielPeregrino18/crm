import 'package:json_annotation/json_annotation.dart';

part 'det_ped_mov_model.g.dart';

@JsonSerializable()
class DetPedMovModel {
  int? ID_ALMACEN;
  int? ID_PEDIDO;
  int? ID_ARTICULO;
  String? NOMBRE;
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
  double? POR_IVA;
  double? POR_IEPS;
  double? POR_PRECIO;
  double? IVA_RETENIDO;
  int? ID_LISTA;
  double? PRECIOLISTA;
  double? PORIVARET;

  DetPedMovModel({
    required this.ID_ALMACEN,
    required this.ID_PEDIDO,
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
    required this.POR_IVA,
    required this.POR_IEPS,
    required this.POR_PRECIO,
    required this.IVA_RETENIDO,
    required this.ID_LISTA,
    required this.PRECIOLISTA,
    required this.PORIVARET,

  });

  factory DetPedMovModel.fromJson(Map<String, dynamic> json) =>
      _$DetPedMovModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetPedMovModelToJson(this);
}
