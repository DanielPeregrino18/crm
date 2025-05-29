import 'package:crm/core/services/api_pos_op_pedido.dart';
import 'package:crm/data/models/pedidos/cabs_ped_cliente.dart';
import 'package:dio/dio.dart';

class CabsPedidoClienteRepositorio {
  final ApiPosOpPedido _apiPosOpPedido;

  CabsPedidoClienteRepositorio()
    : _apiPosOpPedido = ApiPosOpPedido(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<CabsPedCliente>?> getCabsPedCliente(
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
      final List<CabsPedCliente>? pedidos = await _apiPosOpPedido.getCabsPedCliente(
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
      return pedidos;
    } catch (e) {
      rethrow;
    }
  }
}
