import 'package:crm/core/resources/data_state.dart';
import 'package:crm/core/use_cases/use_case.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_ped_mov_params.dart';
import 'package:crm/features/pedido/domain/entities/cab_ped_mov_entities/cab_ped_mov_entity.dart';
import 'package:crm/features/pedido/domain/repositories/cab_ped_mov_repository.dart';

class GetCabPedMovUseCase
    implements UseCase<DataState<CabPedMovEntity?>, GetCabPedMovParams> {
  final CabPedMovRepository _cabPedMovRepository;

  GetCabPedMovUseCase(this._cabPedMovRepository);

  @override
  Future<DataState<CabPedMovEntity?>> call({
    required GetCabPedMovParams params,
  }) {
    return _cabPedMovRepository.getCabPedMov(params);
  }
}
