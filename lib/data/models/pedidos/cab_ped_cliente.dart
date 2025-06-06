import 'package:json_annotation/json_annotation.dart';

part 'cab_ped_cliente.g.dart';

@JsonSerializable()
class CabPedCliente {
  String? Clave;
  String? OrdenCompra;
  DateTime? Fecha;
  String? Nombre;
  String? Total;
  String? estatus;
  String? Observaciones;

  CabPedCliente({
    required this.Clave,
    required this.OrdenCompra,
    required this.Fecha,
    required this.Nombre,
    required this.Total,
    required this.estatus,
    required this.Observaciones,
  });

  factory CabPedCliente.fromJson(Map<String, dynamic> json) =>
      _$CabPedClienteFromJson(json);
  Map<String, dynamic> toJson() => _$CabPedClienteToJson(this);
}
