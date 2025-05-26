import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider =  Provider<Dio>((ref) => Dio(),);

final apiCabCotizacionProvider = Provider<ApiCabCotizaciones>((ref) =>
                                    ApiCabCotizaciones(ref.read(dioProvider)),);