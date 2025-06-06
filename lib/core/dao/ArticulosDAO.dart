
import 'package:crm/domain/entities/articulos_ob.dart';

abstract class ArticulosDAO{

  ArticulosOB getArticuloById(int id);
  void setArticulo(ArticulosOB articulo);

  void cargarArticulos();

}