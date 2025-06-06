import 'package:crm/data/models/colecciones/articulos.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_colecciones.g.dart';

@RestApi(baseUrl: 'http://192.168.1.222:8080/api/POSopColecciones')
abstract class ApiColecciones{

  factory ApiColecciones(Dio dio) = _ApiColecciones;
  @GET('/ObtenerArticulos')
  Future<List<Articulos>> getArticulos(
      @Query('idSaas') String idSaas,
      @Query('idCompany') int idCompany,
      @Query('idSubscription') int idSubscription
      );

}