import 'package:crm/domain/entities/almacen_ob.dart';

// LDB = Local Database

abstract class AlmacenLDBDao {
  AlmacenOB? getAlmacenByIdLDB(int idAlmacenOB);

  List<AlmacenOB> getAllAlmacenesLDB();

  bool agregarAlmacenLDB(AlmacenOB almacenOB);

  bool eliminarAlmacenLDB(int idAlmacenOB);

  bool updateAlmacenLDB(AlmacenOB almacenOB);

  List<AlmacenOB> existeAlmacenPorIdLDB(int idAlmacenOB);
}
