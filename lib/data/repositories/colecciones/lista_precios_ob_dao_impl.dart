import 'package:crm/data/repositories/colecciones/lista_precios_repository.dart';
import 'package:crm/config/DB/object_box_connection.dart';

class ListaPreciosOBDAOImpl {

  final ListaPreciosRepository _listaPreciosRepository;
  final ObjectBoxConnection _objectBoxConnection;

  ListaPreciosOBDAOImpl(this._listaPreciosRepository, this._objectBoxConnection);


}
