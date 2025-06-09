import 'package:crm/core/dao/lista_precios_dao.dart';
import 'package:crm/domain/entities/lista_precios_ob.dart';
import 'package:flutter/cupertino.dart';

class ListaPreciosService {
  final ListaPreciosLDBDAO listaPreciosRepository;

  ListaPreciosService(this.listaPreciosRepository);

  ListaPreciosOB? getListaPrecioById(int idListaPreciosLDB) {
    return listaPreciosRepository.getListaPrecioById(idListaPreciosLDB);
  }

  List<ListaPreciosOB> getAllListaPreciosLDB() {
    return listaPreciosRepository.getAllListaPreciosLDB();
  }

  bool agregarListaPreciosLDB(ListaPreciosOB listaPreciosOB) {
    if (listaPreciosRepository
        .existeListaPreciosByIdLDB(
          listaPreciosOB.ID_LISTA,
          listaPreciosOB.ID_ARTICULO,
        )
        .isNotEmpty) {
      debugPrint('Error al guardar: Registro existente');
      return false;
    }

    return listaPreciosRepository.agregarListaPreciosLDB(listaPreciosOB);
  }

  bool eliminarListaPreciosLDB(int idListaPreciosLDB) {
    return listaPreciosRepository.eliminarListaPreciosLDB(idListaPreciosLDB);
  }

  bool actualizarListaPreciosLDB(ListaPreciosOB listaPreciosLDB) {
    List<ListaPreciosOB> listaExistencias = listaPreciosRepository
        .existeListaPreciosByIdLDB(
          listaPreciosLDB.ID_LISTA,
          listaPreciosLDB.ID_ARTICULO,
        );

    if (listaExistencias.isEmpty) {
      debugPrint(
        'Error al actualizar: Lista de precios no encontrada en local',
      );
      return false;
    }

    return listaPreciosRepository.actualizarListaPreciosLDB(listaPreciosLDB);
  }
}
