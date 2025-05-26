import 'package:crm/data/models/cab_cotizacion.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_cab_cotizaciones.g.dart';
@RestApi(baseUrl: 'http://192.168.1.222:8080/api/operaciones/POSCotizacion')
abstract class ApiCabCotizaciones {

  factory ApiCabCotizaciones(Dio dio) = _ApiCabCotizaciones;

  @GET('/GetCabsCotRango')
  Future<List<CabCotizacion>> getCabsCotizacionesRango(
      @Query('idAlmacen') int idAlmacen,
      @Query('tipoFecha') int tipoFecha,
      @Query('fechaInicio') String fechaInicio,
      @Query('fechaFin') String fechaFin,
      @Query('idCliente') int idCliente,
      @Query('idSaas') String idSaas,
      @Query('idCompany') int idCompany,
      @Query('idSubscription') int idSubscription
      );
  
}