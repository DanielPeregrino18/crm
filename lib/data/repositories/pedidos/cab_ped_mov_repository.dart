import 'package:crm/core/services/op_pedido_api.dart';
import 'package:dio/dio.dart';
import 'package:crm/data/models/pedidos/cab_ped_mov_models/cab_ped_mov_model.dart';

class CabPedMovRepository {
  final OpPedidoApi _opPedidoApi;

  CabPedMovRepository()
    : _opPedidoApi = OpPedidoApi(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<CabPedMovModel?> getCabPedMov(
    int idAlmacen,
    int idPedido,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final CabPedMovModel? pedido = await _opPedidoApi.getCabPedMov(
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
