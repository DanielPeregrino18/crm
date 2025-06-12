import 'dart:io';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_ped_mov_params.dart';
import 'package:crm/features/pedido/domain/repositories/cab_ped_mov_repository.dart';
import 'package:crm/features/pedido/data/data_sources/remote/op_pedido_api_service.dart';
import 'package:dio/dio.dart';
import 'package:crm/core/resources/data_state.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_ped_mov_model.dart';
import 'package:crm/core/constants/constants.dart';

class CabPedMovRepositoryImpl extends CabPedMovRepository {
  final OpPedidoApiService _opPedidoApiService;
  CabPedMovRepositoryImpl(this._opPedidoApiService);

  @override
  Future<DataState<CabPedMovModel?>> getCabPedMov(
    GetCabPedMovParams params,
  ) async {
    try {
      final httpResponse = await _opPedidoApiService.getCabPedMov(
        idAlmacen: params.idAlmacen,
        idPedido: params.idPedido,
        idSaas: idSaas,
        idCompany: idCompany,
        idSubscription: idSubscription,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataException(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataException(e);
    }
  }

  // final OpPedidoApiService _opPedidoApiService;
  //
  // CabPedMovRepositoryImpl()
  //   : _opPedidoApiService = OpPedidoApiService(
  //       Dio(BaseOptions(contentType: "application/json")),
  //     );
  //
  // Future<CabPedMovModel?> getCabPedMov(
  //   int idAlmacen,
  //   int idPedido,
  //   String idSaas,
  //   int idCompany,
  //   int idSubscription,
  // ) async {
  //   try {
  //     final CabPedMovModel? pedido = await _opPedidoApiService.getCabPedMov(
  //       idAlmacen,
  //       idPedido,
  //       idSaas,
  //       idCompany,
  //       idSubscription,
  //     );
  //     return pedido;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
