import 'package:crm/features/pedido/data/data_sources/remote/op_pedido_api_service.dart';
import 'package:dio/dio.dart';
import 'package:crm/features/pedido/data/models/cab_ped_rango_model.dart';

class CabsPedidoRangoRepository {
  final OpPedidoApiService _opPedidoApiService;

  CabsPedidoRangoRepository()
    : _opPedidoApiService = OpPedidoApiService(
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
      final List<CabPedRangoModel>? cabsPedRango = await _opPedidoApiService
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
