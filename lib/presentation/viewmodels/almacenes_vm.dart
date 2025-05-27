import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/core/services/almacenes_servicio.dart';
import 'package:crm/data/models/almacen_model.dart';
import 'package:crm/data/repositories/repositorio_almacenes.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/general_purpose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'almacenes_vm.g.dart';

@riverpod
class AlmacenSeleccionado extends _$AlmacenSeleccionado {
  @override
  Future<AlmacenOB?> build() async {
    return null;
  }

  Future<void> seleccionarAlmacen(AlmacenOB almacenOB) async {
    state = AsyncData(almacenOB);
  }
}

class AlmacenesNotifier extends StateNotifier<List<Almacen>> {
  AlmacenesNotifier() : super([]);

  final RepositorioAlmacenes _repositorioAlmacenes = RepositorioAlmacenes();

  Future<void> fetchAlmacenes(
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
    try {
      final List<Almacen> almacenes = await _repositorioAlmacenes.getData(
        idSaas,
        idCompany,
        idSubscription,
      );

      state = almacenes;

      // final List<Almacen> almacenesSimulados = [
      //   Almacen(0, 0, 'TODOS'),
      //   Almacen(1, 1, 'REFRI-VICENTE'),
      // ];
      //
      // state = almacenesSimulados;

      debugPrint('Datos de almacenes cargados correctamente');
    } catch (e) {
      state = [];
      debugPrint('Error al obtener los datos de almacenes');
    }
  }
}

final almacenesProvider =
    StateNotifierProvider<AlmacenesNotifier, List<Almacen>>((ref) {
      return AlmacenesNotifier();
    });

class AlmacenesViewModel extends ChangeNotifier {
  List<AlmacenOB> almacenes = [];

  List<AlmacenOB> almacenesFiltrados = [];

  AlmacenOB? almacenActualzado;

  final AlmacenServicio _almacenServicio;

  AlmacenesViewModel(this._almacenServicio);

  void getAllAlmacenesLDB() {
    almacenes = _almacenServicio.getAllAlmacenesLDB();
    almacenesFiltrados = almacenes;
  }

  void filtrarAlmacenes(String value) {
    if (value.isEmpty) {
      almacenesFiltrados = almacenes;
    } else {
      almacenesFiltrados =
          almacenes
              .where(
                (almacen) =>
                    almacen.nombre.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  bool eliminarAlmacen(int indexAlmacenFiltrado) {
    int idAlmacenOB = almacenesFiltrados[indexAlmacenFiltrado].id;

    almacenesFiltrados.removeWhere(
      (almacenFiltrado) => almacenFiltrado.id == idAlmacenOB,
    );

    almacenes.removeWhere((almacen) => almacen.id == idAlmacenOB);

    return _almacenServicio.eliminarAlmacenLDB(idAlmacenOB);
  }

  bool agregarAlmacen(AlmacenOB almacenOB) {
    return _almacenServicio.agregarAlmacenLDB(almacenOB);
  }

  void getAlmacenActualizado(int idAlmacenOB) {
    almacenActualzado = _almacenServicio.getAlmacenByIdLDB(idAlmacenOB);
  }

  bool actualizarAlmacen(AlmacenOB almacenOB) {
    almacenActualzado = almacenOB;

    return _almacenServicio.updateAlmacen(almacenOB);
  }
}

// Provider crud almacenes
final almacenesVMProvider = ChangeNotifierProvider<AlmacenesViewModel>((ref) {
  return AlmacenesViewModel(ref.read(almacenServicioProvider));
});

// Almacenes filtrados provider

final almacenesFiltradosProvider = StateProvider<List<AlmacenOB>>((ref) {
  final String inputSearch = ref.watch(inputSearchProvider);
  final List<AlmacenOB> almacenes =
      ref.watch(almacenServicioProvider).getAllAlmacenesLDB();
  return almacenes
      .where(
        (almacenOB) =>
            almacenOB.nombre.toLowerCase().contains(inputSearch.toLowerCase()),
      )
      .toList();
});
