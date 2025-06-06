import 'package:crm/core/services/colecciones/lista_precios_api.dart';
import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:dio/dio.dart';

class ListaPreciosRepository {
  final ListaPreciosApi _listaPreciosApi;

  ListaPreciosRepository()
    : _listaPreciosApi = ListaPreciosApi(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<ListaPreciosModel>?> obtenerListaPrecios(
    int idAlmacen,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<ListaPreciosModel>? listaPrecios = await _listaPreciosApi
          .obtenerListaPrecios(idAlmacen, idSaas, idCompany, idSubscription);
      return listaPrecios;
    } catch (e) {
      rethrow;
    }
  }
}
