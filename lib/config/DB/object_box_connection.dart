import 'package:crm/domain/entities/articulos_ob.dart';
import 'package:crm/domain/entities/lista_precios_ob.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:crm/data/data_sources/objectbox.g.dart';
import 'package:crm/domain/entities/almacen_ob.dart';

class ObjectBoxConnection {
  late final Store _store;

  late final Box<AlmacenOB> almacenBox;
  late final Box<ArticulosOB> articulosBox;
  late final Box<ListaPreciosOB> listaPreciosBox;

  // Obtiene las conexiones a las bases de datos.
  ObjectBoxConnection._create(this._store) {
    almacenBox = Box<AlmacenOB>(_store);
    articulosBox = Box<ArticulosOB>(_store);
    listaPreciosBox = Box<ListaPreciosOB>(_store);
  }

  static Future<ObjectBoxConnection> create() async {
    final Store store = await openStore(
      directory: p.join(
        (await getApplicationDocumentsDirectory()).path,
        "obx-demo",
      ),
      macosApplicationGroup: "objectbox.demo",
    );
    return ObjectBoxConnection._create(store);
  }
}
