import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:crm/data/models/cotizaciones/cab_cotizacion_cliente.dart';
import 'package:crm/data/models/cotizaciones/det_cotizacion_mov.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../data/models/cotizaciones/cab_cotizacion_mov.dart';

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
  
  @GET('/GetCabCotMov')
  Future<CabCotizacionMov> getCabCotMov(
      @Query('idAlmacen') int idAlmacen,
      @Query('idCotizacion') int idCotizacion,
      @Query('idSaas') String idSaas,
      @Query('idCompany') int idCompany,
      @Query('idSubscription') int idSubscription
      );

  @GET('/GetCabsCotCliente')
  Future<List<CabCotizacionCliente>> getCabsCotCliente(
      @Query('idAlmacen') int idAlmacen,
      @Query('idCliente') int idCliente,
      @Query('fechaInicio') String fechaInicio,
      @Query('fechaFin') String fechaFin,
      @Query('idMov') int idMov,
      @Query('ordenCompra') String ordenCompra,
      @Query('idSaas') String idSaas,
      @Query('idCompany') int idCompany,
      @Query('idSubscription') int idSubscription
      );

  @GET('/GetDetCotMov')
  Future<List<DetCotizacionMov>> getDetCotMov(
      @Query('idAlmacen') int idAlmacen,
      @Query('idCotizacion') int idCotizacion,
      @Query('idSaas') String idSaas,
      @Query('idCompany') int idCompany,
      @Query('idSubscription') int idSubscription
      );
}