import 'package:crm/data/models/almacen_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_almacenes.g.dart';

@RestApi(baseUrl: 'http://192.168.1.222:8080/api/')
abstract class ApiAlmacenes {
  factory ApiAlmacenes(Dio dio) = _ApiAlmacenes;

  @GET('InventarioEnLinea/ObtenerAlmacenes')
  Future<List<Almacen>> getData(
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );
}
