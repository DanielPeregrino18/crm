import 'package:dio/dio.dart';
import 'package:crm/core/services/api_pos_op_pedido.dart';
import 'package:crm/data/models/pedidos/pedido_model.dart';

class RepositorioPedidos {
  final ApiPosOpPedido _apiPosOpPedido;

  RepositorioPedidos()
    : _apiPosOpPedido = ApiPosOpPedido(
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
      final Pedido? pedido = await _apiPosOpPedido.getCabPedMov(
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
