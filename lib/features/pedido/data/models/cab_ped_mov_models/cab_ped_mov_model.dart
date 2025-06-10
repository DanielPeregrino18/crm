import 'package:json_annotation/json_annotation.dart';
import 'package:crm/features/pedido/domain/entities/cab_ped_mov_entities/cab_ped_mov_entity.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_pedido_model.dart';

part 'cab_ped_mov_model.g.dart';

@JsonSerializable()
class CabPedMovModel extends CabPedMovEntity {
  const CabPedMovModel({
    int? idListaPrecio,
    String? rfc,
    int? idMoneda,
    CabPedidoModel? cabPedido,
  });

  factory CabPedMovModel.fromJson(Map<String, dynamic> json) =>
      _$CabPedMovModelFromJson(json);
  Map<String, dynamic> toJson() => _$CabPedMovModelToJson(this);
}
