import 'package:crm/data/models/almacen_model.dart';
import 'package:dio/dio.dart';
import 'package:crm/core/services/api_almacenes.dart';

class RepositorioAlmacenes {
  final ApiAlmacenes _apiAlmacenes;

  RepositorioAlmacenes()
    : _apiAlmacenes = ApiAlmacenes(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<Almacen>> getData(
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<Almacen> response = await _apiAlmacenes.getData(
        idSaas,
        idCompany,
        idSubscription,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
