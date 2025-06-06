import 'package:crm/data/models/pedidos/op_pedido_models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'op_pedido_api.g.dart';

@RestApi(baseUrl: 'http://192.168.1.129:8080/api/operaciones/POSopPedido')
abstract class OpPedidoApi {
  factory OpPedidoApi(Dio dio) = _OpPedidoApi;

  @GET('/GetCabPedMov')
  Future<CabPedMovModel?> getCabPedMov(
    @Query('idAlmacen') int idAlmacen,
    @Query('idPedido') int idPedido,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );

  @GET('/GetCabsPedCliente')
  Future<List<CabPedCliente>?> getCabsPedCliente(
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

  @GET('/GetCabsPedRango')
  Future<List<CabPedRangoModel>?> getCabsPedRango(
    @Query('idAlmacen') int idAlmacen,
    @Query('tipoFecha') int tipoFecha,
    @Query('fechaInicio') String fechaInicio,
    @Query('fechaFin') String fechaFin,
    @Query('idCliente') int idCliente,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );

  @GET('/GetDetPedMov')
  Future<List<DetPedMovModel>?> getDetPedMov(
    @Query('idAlmacen') int idAlmacen,
    @Query('idPedido') int idPedido,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );
}
