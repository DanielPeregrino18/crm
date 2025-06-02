import 'package:crm/core/services/op_pedido_api.dart';
import 'package:dio/dio.dart';
import 'package:crm/data/models/pedidos/cab_ped_cliente.dart';

class CabsPedidoClienteRepository {
  final OpPedidoApi _opPedidoApi;

  CabsPedidoClienteRepository()
    : _opPedidoApi = OpPedidoApi(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<CabPedCliente>?> getCabsPedCliente(
    int idAlmacen,
    int idCliente,
    String fechaInicio,
    String fechaFin,
    int idMovimiento,
    String ordenCompra,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<CabPedCliente>? cabsPedCliente = await _opPedidoApi
          .getCabsPedCliente(
            idAlmacen,
            idCliente,
            fechaInicio,
            fechaFin,
            idMovimiento,
            ordenCompra,
            idSaas,
            idCompany,
            idSubscription,
          );
      return cabsPedCliente;
    } catch (e) {
      rethrow;
    }
  }
}
