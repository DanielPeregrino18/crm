import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cab_cotizacion_mov.g.dart';
@JsonSerializable()
class CabCotizacionMov{
  int? idListaPrecio;
  String? noSerie;
  int? idPedidoProcesado;
  String? rfc;
  int? plazo;
  int? moneda;
  CabCotizacion? cabCotizacion;

  CabCotizacionMov(this.idListaPrecio, this.noSerie, this.idPedidoProcesado,
      this.rfc, this.plazo, this.moneda, this.cabCotizacion);

  factory CabCotizacionMov.fromJson(Map<String,dynamic> json) => _$CabCotizacionMovFromJson(json);
  Map<String, dynamic> toJson() => _$CabCotizacionMovToJson(this);
}