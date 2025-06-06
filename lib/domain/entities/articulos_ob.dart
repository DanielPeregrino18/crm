import 'package:objectbox/objectbox.dart';

@Entity()
class ArticulosOB{
  @Id()
  int id;
  int? ID_ARTICULO;
  String? NOMBRE;
  String? CODIGO_BARRAS;
  String? NO_PARTE;
  int? ID_MARCA;
  int? ID_FAMILIA;
  int? ID_CATEGORIA;

  ArticulosOB({
    this.id = 0,
    this.ID_ARTICULO,
    this.NOMBRE,
    this.CODIGO_BARRAS,
    this.NO_PARTE,
    this.ID_MARCA,
    this.ID_FAMILIA,
    this.ID_CATEGORIA
  });
}