import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:crm/data/data_sources/objectbox.g.dart';
import 'package:crm/domain/entities/almacen_ob.dart';

class ObjectBoxConnection {
  late final Store _store;

  late final Box<AlmacenOB> almacenBox;

  // Obtiene las conexiones a las bases de datos.
  ObjectBoxConnection._create(this._store) {
    almacenBox = Box<AlmacenOB>(_store);
  }

  static Future<ObjectBoxConnection> create() async {
    final store = await openStore(
      directory: p.join(
        (await getApplicationDocumentsDirectory()).path,
        "obx-demo",
      ),
      macosApplicationGroup: "objectbox.demo",
    );
    return ObjectBoxConnection._create(store);
  }
}
