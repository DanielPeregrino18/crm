import 'package:crm/data/models/pedido_model.dart';
import 'package:crm/data/repositories/pedidos_repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pedidos_vm.g.dart';

@riverpod
class MovimientoController extends _$MovimientoController {
  @override
  TextEditingController build() {
    return TextEditingController();
  }
}

@riverpod
class GetPedido extends _$GetPedido {
  @override
  Future<Pedido?> build() async {
    return null;
  }

  final RepositorioPedidos _repositorioPedidos = RepositorioPedidos();

  Future<bool> getPedido(
    int idAlmacen,
    int idPedido,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final Pedido? pedido = await _repositorioPedidos.getCabPedMov(
        idAlmacen,
        idPedido,
        idSaas,
        idCompany,
        idSubscription,
      );
      state = AsyncData(pedido);
      return true;
    } catch (e) {
      state = AsyncData(null);
      debugPrint('Error al obtener los datos del pedido: $e');
      return false;
    }
  }
}
