
import 'package:crm/core/dao/ArticulosDAO.dart';
import 'package:crm/core/services/api_colecciones.dart';
import 'package:crm/domain/entities/articulos_ob.dart';

import '../../config/DB/object_box_connection.dart';

class ArticulosObxImpl extends ArticulosDAO{


  final ObjectBoxConnection _connectionDB;
  final ApiColecciones apiColecciones;

  ArticulosObxImpl(this._connectionDB, this.apiColecciones);
  @override
  ArticulosOB getArticuloById(int id) {
    var almacenBox = _connectionDB.articulosBox;
    return almacenBox.get(id)!;
  }

  @override
  void setArticulo(ArticulosOB articulo) {
    var almacenBox = _connectionDB.articulosBox;
    almacenBox.put(articulo);
  }

  @override
  void cargarArticulos() async {
    var almacenBox = _connectionDB.articulosBox;
    if(almacenBox.isEmpty()){
      var res = await apiColecciones.getArticulos("6378459f-59c3-4d81-9fa1-4b07d7bf95a6", 2, 97);
      for (var e in res) {
        setArticulo(
       ArticulosOB(ID_ARTICULO: e.ID_ARTICULO, NOMBRE: e.NOMBRE, CODIGO_BARRAS: e.CODIGO_BARRAS, NO_PARTE: e.NO_PARTE,
              ID_MARCA: e.ID_MARCA, ID_FAMILIA: e.ID_FAMILIA, ID_CATEGORIA: e.ID_CATEGORIA));
      }
    }
  }

}