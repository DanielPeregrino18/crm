import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:crm/data/models/pedidos/pedidos_modelos.dart';

part 'api_pos_op_pedido.g.dart';

@RestApi(baseUrl: 'http://192.168.1.222:8080/api/operaciones/POSopPedido')
abstract class ApiPosOpPedido {
  factory ApiPosOpPedido(Dio dio) = _ApiPosOpPedido;

  @GET('/GetCabPedMov')
  Future<Pedido?> getCabPedMov(
    @Query('idAlmacen') int idAlmacen,
    @Query('idPedido') int idPedido,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );

  @GET('/GetCabsPedCliente')
  Future<List<CabsPedCliente>?> getCabsPedCliente(
    @Query('idAlmacen') int idAlmacen,
    @Query('idCliente') int idCliente,
    @Query('fechaInicio') String fechaInicio,
    @Query('fechaFin') String fechaFin,
    @Query('idMovimiento') int idMovimiento,
    @Query('ordenCompra') String ordenCompra,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );
}
