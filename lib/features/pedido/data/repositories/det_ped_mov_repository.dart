import 'package:crm/features/pedido/data/data_sources/remote/op_pedido_api_service.dart';
import 'package:crm/features/pedido/data/models/det_ped_mov_model.dart';
import 'package:dio/dio.dart';

class DetPedMovRepository {
  final OpPedidoApiService _opPedidoApiService;

  DetPedMovRepository()
    : _opPedidoApiService = OpPedidoApiService(
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
      final List<DetPedMovModel>? detPedMov = await _opPedidoApiService.getDetPedMov(
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
