import 'package:crm/data/models/pedido_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_cab_pedidos.g.dart';

@RestApi(baseUrl: 'http://192.168.1.222:8080/api/operaciones/POSopPedido')
abstract class ApiCabPedidos {
  factory ApiCabPedidos(Dio dio) = _ApiCabPedidos;

  @GET('/GetCabPedMov')
  Future<Pedido?> getCabPedMov(
    @Query('idAlmacen') int idAlmacen,
    @Query('idPedido') int idPedido,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );
}
