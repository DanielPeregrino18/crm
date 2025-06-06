import 'package:crm/domain/entities/lista_precios_ob.dart';

abstract class ListaPreciosDAO {
  ListaPreciosOB getListaPrecioById(int id);
  void obtenerListaPrecios;
  void guardarListaPrecios;
}
