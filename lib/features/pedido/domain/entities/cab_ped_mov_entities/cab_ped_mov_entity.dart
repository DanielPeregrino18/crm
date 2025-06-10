import 'package:equatable/equatable.dart';
import 'package:crm/features/pedido/data/models/cab_ped_mov_models/cab_pedido_model.dart';

class CabPedMovEntity extends Equatable {
  final int? idListaPrecio;
  final String? rfc;
  final int? idMoneda;
  final CabPedidoModel? cabPedido;

  const CabPedMovEntity({
    this.idListaPrecio,
    this.rfc,
    this.idMoneda,
    this.cabPedido,
  });

  @override
  List<Object?> get props {
    return [idListaPrecio, rfc, idMoneda, cabPedido];
  }
}
