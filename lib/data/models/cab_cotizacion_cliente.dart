import 'package:json_annotation/json_annotation.dart';

part 'cab_cotizacion_cliente.g.dart';

@JsonSerializable()
class CabCotizacionCliente{
  String? Clave;
  String? OrdenCompra;
  DateTime? Fecha;
  String? Nombre;
  String? Total;
  String? estatus;
  String? Observaciones;

  CabCotizacionCliente(this.Clave, this.OrdenCompra, this.Fecha, this.Nombre,
      this.Total, this.estatus, this.Observaciones);

  factory CabCotizacionCliente.fromJson(Map<String,dynamic> json) => _$CabCotizacionClienteFromJson(json);
  Map<String, dynamic> toJson() => _$CabCotizacionClienteToJson(this);
}