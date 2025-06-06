import 'package:json_annotation/json_annotation.dart';

part 'articulos.g.dart';
@JsonSerializable()
class Articulos {
    int?  ID_ARTICULO;
    String? NOMBRE;
    String? CODIGO_BARRAS;
    String? NO_PARTE;
    int? ID_MARCA;
    int? ID_FAMILIA;
    int? ID_CATEGORIA;

    Articulos(this.ID_ARTICULO, this.NOMBRE, this.CODIGO_BARRAS, this.NO_PARTE,
        this.ID_MARCA, this.ID_FAMILIA, this.ID_CATEGORIA);

    factory Articulos.fromJson(Map<String,dynamic> json) => _$ArticulosFromJson(json);
    Map<String, dynamic> toJson() => _$ArticulosToJson(this);
}