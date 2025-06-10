import 'package:crm/core/dao/almacen_dao.dart';
import 'package:crm/domain/entities/almacen_ob.dart';

class AlmacenServicio {
  final AlmacenLDBDao almacenRepositorio;

  AlmacenServicio(this.almacenRepositorio);

  List<AlmacenOB> getAllAlmacenesLDB() {
    return almacenRepositorio.getAllAlmacenesLDB();
  }

  bool agregarAlmacenLDB(AlmacenOB almacenOB) {
    if (almacenRepositorio
        .existeAlmacenPorIdLDB(almacenOB.id_almacen)
        .isNotEmpty) {
      return false;
    }

    return almacenRepositorio.agregarAlmacenLDB(almacenOB);
  }

  bool eliminarAlmacenLDB(int idAlmacenOB) {
    return almacenRepositorio.eliminarAlmacenLDB(idAlmacenOB);
  }

  AlmacenOB? getAlmacenByIdLDB(int idAlmacenOB) {
    AlmacenOB? almacenOB = almacenRepositorio.getAlmacenByIdLDB(idAlmacenOB);

    if (almacenOB != null) {
      return almacenOB;
    } else {
      throw Exception("Almacen no encontrado");
    }
  }

  bool updateAlmacen(AlmacenOB almacenOB) {
    List<AlmacenOB> almId = almacenRepositorio.existeAlmacenPorIdLDB(
      almacenOB.id,
    );

    if (almId.isNotEmpty) {
      if (almId[0].id != almacenOB.id) {
        return false;
      }
    }

    return almacenRepositorio.updateAlmacenLDB(almacenOB);
  }
}
