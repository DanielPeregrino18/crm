import 'package:json_annotation/json_annotation.dart';

part 'almacen_model.g.dart';

@JsonSerializable()
class Almacen {
  int id_sucursal;

  int id_almacen;

  String nombre;

  Almacen(this.id_sucursal, this.id_almacen, this.nombre);

  factory Almacen.fromJson(Map<String, dynamic> json) =>
      _$AlmacenFromJson(json);

  Map<String, dynamic> toJson() => _$AlmacenToJson(this);
}
