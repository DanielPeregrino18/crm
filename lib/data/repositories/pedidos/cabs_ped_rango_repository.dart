import 'package:crm/core/services/op_pedido_api.dart';
import 'package:dio/dio.dart';
import 'package:crm/data/models/pedidos/cab_ped_rango_model.dart';

class CabsPedidoRangoRepository {
  final OpPedidoApi _opPedidoApi;

  CabsPedidoRangoRepository()
    : _opPedidoApi = OpPedidoApi(
        Dio(BaseOptions(contentType: "application/json")),
      );

  Future<List<CabPedRangoModel>?> getCabsPedRango(
    int idAlmacen,
    int tipoFecha,
    String fechaInicio,
    String fechaFin,
    int idCliente,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<CabPedRangoModel>? cabsPedRango = await _opPedidoApi
          .getCabsPedRango(
            idAlmacen,
            tipoFecha,
            fechaInicio,
            fechaFin,
            idCliente,
            idSaas,
            idCompany,
            idSubscription,
          );
      return cabsPedRango;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }
}
