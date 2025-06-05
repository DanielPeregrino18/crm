import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crm/core/utils/fecha.dart';
import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/data/models/pedidos/op_pedido_models.dart';
import 'package:crm/data/repositories/pedidos/op_pedido_repositories.dart';

part 'op_pedido_vm.g.dart';

Fecha fecha = Fecha();

// Provider de uso general para el módulo de pedidos
@riverpod
class PedidoVM extends _$PedidoVM {
  @override
  PedidoVM build() {
    return PedidoVM();
  }

  String idSaas = '6378459f-59c3-4d81-9fa1-4b07d7bf95a6';
  int idCompany = 2;
  int idSubscription = 97;

  AlmacenSeleccionado almacenSeleccionado = AlmacenSeleccionado(
    id: 0,
    nombre: 'TODOS',
  );

  int tipoFecha = 1;
  String fechaInicio = fecha.ayerString;
  String fechaFin = fecha.hoyString;

  int idCliente = 0;

  String FECHA_OC = '';

  String FECHA_INICIOC = '';

  String FECHA_FINC = '';

  List<TextInputFormatter> numberTextInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ];

  void seleccionarAlmacen(int id, String nombre) {
    almacenSeleccionado = AlmacenSeleccionado(id: id, nombre: nombre);
  }

  final SearchController clienteSearchController = SearchController();
}

// Provider para la obtención de un pedido por número de movimiento
@riverpod
class CabPedMovVM extends _$CabPedMovVM {
  @override
  Future<CabPedMovModel?> build() async {
    return null;
  }

  int idAlmacen = 0;

  late PedidoVM pedidosVM = ref.watch(pedidoVMProvider);

  final CabPedMovRepository _cabPedMovRepository = CabPedMovRepository();

  Future<bool> getCabPedMov(int idAlmacen, int idPedido) async {
    try {
      final CabPedMovModel? pedido = await _cabPedMovRepository.getCabPedMov(
        idAlmacen,
        idPedido,
        pedidosVM.idSaas,
        pedidosVM.idCompany,
        pedidosVM.idSubscription,
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
class CabsPedClienteVM extends _$CabsPedClienteVM {
  @override
  Future<List<CabPedCliente>?> build() async {
    return null;
  }

  int? idAlmacen;

  late PedidoVM pedidosVM = ref.watch(pedidoVMProvider);

  final TextEditingController clienteController = TextEditingController();
  final TextEditingController ordenCompraController = TextEditingController();
  final TextEditingController folioController = TextEditingController();

  final CabsPedidoClienteRepository _cabsPedidoClienteRepository =
      CabsPedidoClienteRepository();

  Future<bool> getCabsPedCliente() async {
    try {
      final List<CabPedCliente>? cabsPedCliente =
          await _cabsPedidoClienteRepository.getCabsPedCliente(
            idAlmacen ?? 0,
            int.parse(clienteController.text),
            pedidosVM.fechaInicio,
            pedidosVM.fechaFin,
            int.parse(folioController.text),
            ordenCompraController.text,
            pedidosVM.idSaas,
            pedidosVM.idCompany,
            pedidosVM.idSubscription,
          );
      state = AsyncData(cabsPedCliente);
      debugPrint('Número de resultados: ${state.value?.length}');
      return true;
    } catch (e) {
      state = AsyncData(null);
      debugPrint('Error al obtener los datos del pedido: $e');
      return false;
    }
  }
}

@riverpod
class CabsPedRangoVM extends _$CabsPedRangoVM {
  @override
  FutureOr<List<CabPedRangoModel>?> build() async {
    return null;
  }

  late PedidoVM pedidosVM = ref.watch(pedidoVMProvider);

  final CabsPedidoRangoRepository _cabsPedidoRangoRepository =
      CabsPedidoRangoRepository();

  Future<bool> getCabsPedRango() async {
    try {
      final List<CabPedRangoModel>? cabsPedRango =
          await _cabsPedidoRangoRepository.getCabsPedRango(
            pedidosVM.almacenSeleccionado.id,
            pedidosVM.tipoFecha,
            pedidosVM.fechaInicio,
            pedidosVM.fechaFin,
            pedidosVM.idCliente,
            pedidosVM.idSaas,
            pedidosVM.idCompany,
            pedidosVM.idSubscription,
          );
      state = AsyncData(cabsPedRango);
      debugPrint('Número de resultados: ${state.value?.length}');
      return true;
    } catch (e) {
      state = AsyncData(null);
      debugPrint('$e');
      return false;
    }
  }
}

@riverpod
class DetPedMovVM extends _$DetPedMovVM {
  @override
  FutureOr<Map<int, List<DetPedMovModel>?>> build() async {
    return {};
  }

  late PedidoVM pedidosVM = ref.watch(pedidoVMProvider);

  final DetPedMovRepository _detPedMovRepository = DetPedMovRepository();

  Future<bool> getDetPedMov(int idAlmacen, int idPedido) async {
    try {
      final List<DetPedMovModel>? detPedMov = await _detPedMovRepository
          .getDetPedMov(
            idAlmacen,
            idPedido,
            pedidosVM.idSaas,
            pedidosVM.idCompany,
            pedidosVM.idSubscription,
          );
      state = AsyncData({...?state.value, idPedido: detPedMov});
      debugPrint('Detalles del pedido cargados correctamente');
      return true;
    } catch (e) {
      debugPrint('$e');
      state = AsyncData({...?state.value, idPedido: null});
      return false;
    }
  }
}
