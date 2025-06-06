import 'package:objectbox/objectbox.dart';

@Entity()
class ListaPreciosOB {
  @Id()
  int id;
  int? ID_LISTA;
  int? ID_ARTICULO;
  double? PRECIO;
  double? DESCUENTO;

  ListaPreciosOB({
    this.id = 0,
    this.ID_LISTA,
    this.ID_ARTICULO,
    this.PRECIO,
    this.DESCUENTO,
  });
}
