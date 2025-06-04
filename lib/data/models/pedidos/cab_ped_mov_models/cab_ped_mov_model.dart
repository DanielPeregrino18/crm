import 'package:crm/data/models/pedidos/cab_ped_mov_models/cab_pedido_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cab_ped_mov_model.g.dart';

@JsonSerializable()
class CabPedMovModel {

  int? idListaPrecio;
  String? rfc;
  int? idMoneda;

  CabPedidoModel? cabPedido;

  CabPedMovModel({
    required this.idListaPrecio,
    required this.rfc,
    required this.idMoneda,
    required this.cabPedido,
  });

  factory CabPedMovModel.fromJson(Map<String, dynamic> json) =>
      _$CabPedMovModelFromJson(json);
  Map<String, dynamic> toJson() => _$CabPedMovModelToJson(this);
}
