import 'package:json_annotation/json_annotation.dart';

part 'lista_precios_model.g.dart';

@JsonSerializable()
class ListaPreciosModel {
  int ID_LISTA;
  int ID_ARTICULO;
  double PRECIO;
  double DESCUENTO;

  ListaPreciosModel({
    required this.ID_LISTA,
    required this.ID_ARTICULO,
    required this.PRECIO,
    required this.DESCUENTO,
  });

  factory ListaPreciosModel.fromJson(Map<String, dynamic> json) =>
      _$ListaPreciosModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListaPreciosModelToJson(this);
}
