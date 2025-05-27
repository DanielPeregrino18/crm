import 'package:crm/config/DB/object_box_connection.dart';
import 'package:crm/core/dao/almacen_dao.dart';
import 'package:crm/core/services/almacenes_servicio.dart';
import 'package:crm/core/services/api_cab_cotizaciones.dart';
import 'package:crm/data/repositories/almacen_dao_objectbox_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider =  Provider<Dio>((ref) => Dio(),);

final apiCabCotizacionProvider = Provider<ApiCabCotizaciones>((ref) =>
                                    ApiCabCotizaciones(ref.read(dioProvider)),);

// ObjectBox
final objectBoxProvider = Provider<ObjectBoxConnection>(
      (ref) => throw UnimplementedError(),
);

// Almacenes
final almacenDaoImplProvider = Provider<AlmacenLDBDao>(
      (ref) => AlmacenDAOObjectboxImpl(ref.read(objectBoxProvider)),
);

final almacenServicioProvider = Provider<AlmacenServicio>(
      (ref) => AlmacenServicio(ref.read(almacenDaoImplProvider)),
);
