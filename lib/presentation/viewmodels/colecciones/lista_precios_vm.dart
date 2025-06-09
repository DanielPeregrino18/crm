import 'package:crm/core/services/colecciones/lista_precios_service.dart';
import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:crm/data/repositories/colecciones/lista_precios_ob_dao_impl.dart';
import 'package:crm/data/repositories/colecciones/lista_precios_repository.dart';
import 'package:crm/domain/entities/lista_precios_ob.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'lista_precios_vm.g.dart';

int idAlmacen = 0;
String idSaas = '6378459f-59c3-4d81-9fa1-4b07d7bf95a6';
int idCompany = 2;
int idSubscription = 97;

@riverpod
class ListaPreciosVM extends _$ListaPreciosVM {
  @override
  Future<List<ListaPreciosModel>?> build() async {
    return obtenerListaPrecios();
  }

  final ListaPreciosRepository _listaPreciosRepository =
      ListaPreciosRepository();

  Future<List<ListaPreciosModel>?> obtenerListaPrecios() async {
    try {
      final List<ListaPreciosModel>? listaPrecios =
          await _listaPreciosRepository.obtenerListaPrecios(
            idAlmacen,
            idSaas,
            idCompany,
            idSubscription,
          );
      debugPrint(
        'Longitud lista precios: ${listaPrecios == null ? 'Lista vacía' : listaPrecios.length}',
      );
      return listaPrecios;
    } catch (e) {
      debugPrint('Error al obtener los datos de listas de precios: $e');
      return null;
    }
  }
}

@riverpod
class ListaPreciosDAOVM extends _$ListaPreciosDAOVM {
  @override
  ListaPreciosOBDAOImpl build() {
    return ListaPreciosOBDAOImpl();
  }
}

@riverpod
class ListaPreciosServiceVM extends _$ListaPreciosServiceVM {
  @override
  ListaPreciosService build() {
    final dao = ref.read(listaPreciosDAOVMProvider);
    return ListaPreciosService(dao);
  }
}

@riverpod
class ListaPreciosLDBVM extends _$ListaPreciosLDBVM {
  late final ListaPreciosService _listaPreciosService;

  @override
  List<ListaPreciosOB> build() {
    _listaPreciosService = ref.read(listaPreciosServiceVMProvider);
    return [];
  }

  ListaPreciosOB? getListaPrecioById(int idListaPreciosLDB) {
    return _listaPreciosService.getListaPrecioById(idListaPreciosLDB);
  }

  void getAllListaPreciosLDB() {
    state = _listaPreciosService.getAllListaPreciosLDB();
  }

  bool agregarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    return _listaPreciosService.agregarListaPreciosLDB(listaPreciosLDB);
  }

  bool eliminarListaPreciosLDB(int idListaPreciosLDB) {
    return _listaPreciosService.eliminarListaPreciosLDB(idListaPreciosLDB);
  }

  bool actualizarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    return _listaPreciosService.actualizarListaPreciosLDB(listaPreciosLDB);
  }
}

@riverpod
class Hola extends _$Hola {
  late final ListaPreciosService _listaPreciosService;

  @override
  List<ListaPreciosOB> build() {
    _listaPreciosService = ref.read(listaPreciosServiceVMProvider);
    return [];
  }

  ListaPreciosOB? getListaPrecioById(int idListaPreciosLDB) {
    return _listaPreciosService.getListaPrecioById(idListaPreciosLDB);
  }

  void getAllListaPreciosLDB() {
    state = _listaPreciosService.getAllListaPreciosLDB();
  }

  bool agregarListaPreciosLDB(List<ListaPreciosModel>? listaPreciosCargada) {
    try {
      if (listaPreciosCargada != null && listaPreciosCargada.isNotEmpty) {
        late List<ListaPreciosOB> listaPreciosOB = [];

        for (ListaPreciosModel item in listaPreciosCargada) {
          ListaPreciosOB list = ListaPreciosOB(
            ID_LISTA: item.ID_LISTA,
            ID_ARTICULO: item.ID_ARTICULO,
            PRECIO: item.PRECIO,
            DESCUENTO: item.DESCUENTO,
          );
          listaPreciosOB.add(list);
        }

        final dao = ref.read(listaPreciosDAOVMProvider);
        dao.listaPreciosBox.putMany(listaPreciosOB);
        debugPrint('Longitud lista precios local: ${dao.listaPreciosBox.count()}');

        return true;
      } else {
        debugPrint('Lista de precios cargada vacía');
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  bool eliminarListaPreciosLDB(int idListaPreciosLDB) {
    return _listaPreciosService.eliminarListaPreciosLDB(idListaPreciosLDB);
  }

  bool actualizarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    return _listaPreciosService.actualizarListaPreciosLDB(listaPreciosLDB);
  }
}
