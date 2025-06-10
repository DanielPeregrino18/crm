import 'package:dio/dio.dart';
import 'package:crm/features/pedido/data/data_sources/remote/op_pedido_api_service.dart';
import 'package:crm/features/pedido/data/models/cab_ped_cliente_model.dart';

class CabsPedidoClienteRepository {
  final OpPedidoApiService _opPedidoApiService;

  CabsPedidoClienteRepository()
    : _opPedidoApiService = OpPedidoApiService(
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
      final List<CabPedCliente>? cabsPedCliente = await _opPedidoApiService
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
