import 'package:json_annotation/json_annotation.dart';

part 'det_cotizacion_mov.g.dart';
@JsonSerializable()
class DetCotizacionMov{
  int? ID_ALMACEN;
  int? ID_COTIZACION;
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


  DetCotizacionMov(this.ID_ALMACEN, this.ID_COTIZACION, this.ID_ARTICULO,
      this.NOMBRE, this.UNIDAD, this.FACTOR_COMPRAVENTA, this.CANTIDAD,
      this.CANTIDAD_AUX, this.IMPORTE, this.DESCUENTO, this.IEPS, this.IVA,
      this.CANTIDAD_FACTURADA, this.CANTIDAD_FACT_AUX, this.SERIE, this.POR_IVA,
      this.POR_IEPS, this.POR_PRECIO, this.IVA_RETENIDO, this.ID_LISTA,
      this.PRECIOLISTA, this.PORIVARET);

  factory DetCotizacionMov.fromJson(Map<String,dynamic> json) => _$DetCotizacionMovFromJson(json);
  Map<String, dynamic> toJson() => _$DetCotizacionMovToJson(this);
}