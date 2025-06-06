import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:crm/data/repositories/colecciones/lista_precios_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'lista_precios_vm.g.dart';

@riverpod
class ListaPreciosVM extends _$ListaPreciosVM {
  @override
  Future<List<ListaPreciosModel>?> build() async {
    return obtenerListaPrecios(
      0,
      '6378459f-59c3-4d81-9fa1-4b07d7bf95a6',
      10,
      97,
    );
  }

  final ListaPreciosRepository _listaPreciosRepository =
      ListaPreciosRepository();

  Future<List<ListaPreciosModel>?> obtenerListaPrecios(
    int idAlmacen,
    String idSaas,
    int idCompany,
    int idSubscription,
  ) async {
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
