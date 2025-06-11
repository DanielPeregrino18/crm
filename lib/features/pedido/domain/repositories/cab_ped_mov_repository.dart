import 'package:crm/core/resources/data_state.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_ped_mov_model.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_ped_mov_params.dart';

abstract class CabPedMovRepository {
  Future<DataState<CabPedMovModel?>> getCabPedMov(GetCabPedMovParams getCabPedMovParams);
}
