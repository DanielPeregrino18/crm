import 'package:json_annotation/json_annotation.dart';

part 'cabs_ped_cliente.g.dart';

@JsonSerializable()
class CabsPedCliente {
  String Clave;

  String OrdenCompra;

  String Fecha;
  String Nombre;
  String Total;
  String estatus;
  String Observaciones;

  CabsPedCliente({
    required this.Clave,
    required this.OrdenCompra,
    required this.Fecha,
    required this.Nombre,
    required this.Total,
    required this.estatus,
    required this.Observaciones,
  });

  factory CabsPedCliente.fromJson(Map<String, dynamic> json) =>
      _$CabsPedClienteFromJson(json);
  Map<String, dynamic> toJson() => _$CabsPedClienteToJson(this);
}
