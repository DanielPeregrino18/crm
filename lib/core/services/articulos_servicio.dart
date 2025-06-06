
import 'package:crm/core/dao/ArticulosDAO.dart';
import 'package:crm/domain/entities/articulos_ob.dart';

class ArticuloServicio{

  final ArticulosDAO articulosDAO;
  ArticuloServicio(this.articulosDAO);

  ArticulosOB getArticuloById(int id){
    return articulosDAO.getArticuloById(id);
  }

  void setArticulo(ArticulosOB articulo){
    articulosDAO.setArticulo(articulo);
  }

}