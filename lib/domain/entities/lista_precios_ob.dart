import 'package:objectbox/objectbox.dart';

@Entity()
class ListaPreciosOB {
  @Id()
  int id;
  int ID_LISTA;
  int ID_ARTICULO;
  double PRECIO;
  double DESCUENTO;

  ListaPreciosOB({
    this.id = 0,
    required this.ID_LISTA,
    required this.ID_ARTICULO,
    required this.PRECIO,
    required this.DESCUENTO,
  });
}
