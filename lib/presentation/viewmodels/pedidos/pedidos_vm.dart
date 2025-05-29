import 'package:crm/core/utils/fechas.dart';
import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/data/models/pedidos/cabs_ped_cliente.dart';
import 'package:crm/data/models/pedidos/pedido_model.dart';
import 'package:crm/data/repositories/pedidos/cabs_pedido_cliente_repositorio.dart';
import 'package:crm/data/repositories/pedidos/pedidos_repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pedidos_vm.g.dart';

@riverpod
class GetPedido extends _$GetPedido {
  @override
  Future<Pedido?> build() async {
    return null;
  }

  final TextEditingController movimientoController = TextEditingController();

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

// Provider para la obtención de los pedidos por cliente
@riverpod
class GetCabsPedCliente extends _$GetCabsPedCliente {
  @override
  Future<List<CabsPedCliente>?> build() async {
    return null;
  }

  final TextEditingController almacenController = TextEditingController();
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController ordenesCompraController = TextEditingController();
  final TextEditingController folioController = TextEditingController();
  final CabsPedidoClienteRepositorio _cabsPedidoClienteRepositorio =
      CabsPedidoClienteRepositorio();

  Future<bool> getCabsPedCliente(
    int idAlmacen,
    int idCliente,
    String fechaInicio,
    String fechaFin,
    int idMovimiento,
    String ordenCompra,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<CabsPedCliente>? pedidos = await _cabsPedidoClienteRepositorio
          .getCabsPedCliente(
            idAlmacen,
            idCliente,
            fechaInicio,
            fechaFin,
            idMovimiento,
            ordenCompra,
            idSaas,
            idCompany,
            idSubscription,
          );
      state = AsyncData(pedidos);
      return true;
    } catch (e) {
      state = AsyncData(null);
      debugPrint('Error al obtener los datos del pedido: $e');
      return false;
    }
  }
}

@riverpod
class PedidosVM extends _$PedidosVM {
  AlmacenSeleccionado almacenSeleccionado = AlmacenSeleccionado(
    id: 0,
    nombre: 'TODOS',
  );

  int tipoFecha = 1;

  String fechaInicial = Fechas().ayerString();

  String fechaFinal = Fechas().hoyString();

  String FECHA_OC = '';

  String FECHA_INICIOC = '';

  String FECHA_FINC = '';

  @override
  PedidosVM build() {
    return PedidosVM();
  }

  void seleccionarAlmacen(int id, String nombre) {
    almacenSeleccionado = AlmacenSeleccionado(id: id, nombre: nombre);
  }
}
