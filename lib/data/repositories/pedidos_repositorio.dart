import 'package:crm/core/services/api_cab_pedidos.dart';
import 'package:crm/data/models/pedido_model.dart';
import 'package:dio/dio.dart';

class RepositorioPedidos {
  final ApiCabPedidos _apiCabPedidos;

  RepositorioPedidos()
    : _apiCabPedidos = ApiCabPedidos(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<Pedido?> getCabPedMov(
    int idAlmacen,
    int idPedido,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final Pedido? pedido = await _apiCabPedidos.getCabPedMov(
        idAlmacen,
        idPedido,
        idSaas,
        idCompany,
        idSubscription,
      );
      return pedido;
    } catch (e) {
      rethrow;
    }
  }
}
