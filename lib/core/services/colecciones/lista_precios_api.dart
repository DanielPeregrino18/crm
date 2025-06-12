import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'lista_precios_api.g.dart';

@RestApi(baseUrl: 'http://192.168.1.222:8080/api/POSopColecciones')
abstract class ListaPreciosApi {
  factory ListaPreciosApi(Dio dio) = _ListaPreciosApi;

  @GET('/ObtenerListaPrecios')
  Future<List<ListaPreciosModel>?> obtenerListaPrecios(
    @Query('idAlmacen') int idAlmacen,
    @Query('idSaas') String idSaas,
    @Query('idCompany') int idCompany,
    @Query('idSubscription') int idSubscription,
  );
}
