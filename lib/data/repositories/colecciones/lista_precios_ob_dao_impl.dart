import 'package:crm/core/dao/lista_precios_dao.dart';
import 'package:crm/config/DB/object_box_connection.dart';
import 'package:crm/domain/entities/lista_precios_ob.dart';
import 'package:crm/data/data_sources/objectbox.g.dart';

class ListaPreciosOBDAOImpl extends ListaPreciosLDBDAO {
  final listaPreciosBox = ObjectBoxConnection.instance.listaPreciosBox;

  @override
  ListaPreciosOB? getListaPrecioById(int idListaPreciosLDB) {
    return listaPreciosBox.get(idListaPreciosLDB);
  }

  @override
  List<ListaPreciosOB> getAllListaPreciosLDB() {
    return listaPreciosBox.getAll();
  }

  @override
  bool agregarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    try {
      listaPreciosBox.put(listaPreciosLDB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool eliminarListaPreciosLDB(int idListaPreciosLDB) {
    try {
      listaPreciosBox.remove(idListaPreciosLDB);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool actualizarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    return agregarListaPreciosLDB(listaPreciosLDB);
  }

  @override
  List<ListaPreciosOB> existeListaPreciosByIdLDB(int idLista, int idArticulo) {
    return listaPreciosBox
        .query(
          ListaPreciosOB_.ID_LISTA.equals(idLista) &
              ListaPreciosOB_.ID_ARTICULO.equals(idArticulo),
        )
        .build()
        .find();
  }
}
