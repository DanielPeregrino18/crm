import 'package:crm/domain/entities/lista_precios_ob.dart';

abstract class ListaPreciosLDBDAO {
  ListaPreciosOB? getListaPrecioById(int idListaPreciosLDB);
  List<ListaPreciosOB> getAllListaPreciosLDB();
  bool agregarListaPreciosLDB(ListaPreciosOB listaPreciosLDB);
  bool eliminarListaPreciosLDB(int idListaPreciosLDB);
  bool actualizarListaPreciosLDB(ListaPreciosOB listaPreciosLDB);
  List<ListaPreciosOB> existeListaPreciosByIdLDB(int idLista, int idArticulo);
}
