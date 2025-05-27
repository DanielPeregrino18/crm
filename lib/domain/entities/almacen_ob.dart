import 'package:objectbox/objectbox.dart';

@Entity()
class AlmacenOB {
  @Id()
  int id;

  int id_sucursal;

  int id_almacen;

  String nombre;

  AlmacenOB({
    this.id = 0,
    required this.id_sucursal,
    required this.id_almacen,
    required this.nombre,
  });
}
