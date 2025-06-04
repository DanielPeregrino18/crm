import 'package:crm/core/services/op_pedido_api.dart';
import 'package:crm/data/models/pedidos/det_ped_mov_model.dart';
import 'package:dio/dio.dart';

class DetPedMovRepository {
  final OpPedidoApi _opPedidoApi;

  DetPedMovRepository()
    : _opPedidoApi = OpPedidoApi(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<DetPedMovModel>?> getDetPedMov(
    int idAlmacen,
    int idPedido,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<DetPedMovModel>? detPedMov = await _opPedidoApi.getDetPedMov(
        idAlmacen,
        idPedido,
        idSaas,
        idCompany,
        idSubscription,
      );
      return detPedMov;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }
}
