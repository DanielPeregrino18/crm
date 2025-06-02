import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crm/core/utils/fechas.dart';
import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/data/models/pedidos/op_pedido_models.dart';
import 'package:crm/data/repositories/pedidos/op_pedido_repositories.dart';

part 'op_pedido_vm.g.dart';

// Provider de uso general para el módulo de pedidos
@riverpod
class PedidoVM extends _$PedidoVM {
  @override
  PedidoVM build() {
    return PedidoVM();
  }

  String idSaas = '19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df';
  int idCompany = 2;
  int idSubscription = 10;

  AlmacenSeleccionado almacenSeleccionado = AlmacenSeleccionado(
    id: 0,
    nombre: 'TODOS',
  );

  int tipoFecha = 1;

  String fechaInicio = Fechas().ayerString();

  String fechaFin = Fechas().hoyString();

  String FECHA_OC = '';

  String FECHA_INICIOC = '';

  String FECHA_FINC = '';

  List<TextInputFormatter> numberTextInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ];

  void seleccionarAlmacen(int id, String nombre) {
    almacenSeleccionado = AlmacenSeleccionado(id: id, nombre: nombre);
  }

  final TextEditingController clienteController = TextEditingController();
}

// Provider para la obtención de un pedido por número de movimiento
@riverpod
class CabPedMovVM extends _$CabPedMovVM {
  @override
  Future<CabPedMovModel?> build() async {
    return null;
  }

  late PedidoVM pedidosVM = ref.watch(pedidoVMProvider);

  final TextEditingController movimientoController = TextEditingController();

  final CabPedMovRepository _cabPedMovRepository = CabPedMovRepository();

  Future<bool> getCabPedMov(int idPedido) async {
    try {
      final CabPedMovModel? pedido = await _cabPedMovRepository.getCabPedMov(
        pedidosVM.almacenSeleccionado.id,
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
            pedidosVM.almacenSeleccionado.id,
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
            0,
            pedidosVM.idSaas,
            pedidosVM.idCompany,
            pedidosVM.idSubscription,
          );
      // await _cabsPedidoRangoRepository.getCabsPedRango(
      //   1,
      //   1,
      //   '01/01/2025',
      //   '30/05/2025',
      //   0,
      //   pedidosVM.idSaas,
      //   pedidosVM.idCompany,
      //   pedidosVM.idSubscription,
      // );
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
