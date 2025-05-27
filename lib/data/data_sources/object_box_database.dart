import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart';

class ObjectBoxDatabase {
  static ObjectBoxDatabase? _instance;

  late final Store _store;

  late final Box<dynamic> dataBox;

  ObjectBoxDatabase._create(this._store) {
    dataBox = Box<dynamic>(_store);
  }

  static Future<ObjectBoxDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: path.join(docsDir.path, "objectbox"),
    );
    _instance = ObjectBoxDatabase._create(store);
    return _instance!;
  }

  static ObjectBoxDatabase get instance {
    if (_instance == null) {
      throw Exception(
        'ObjectBoxDatabase no ha sido inicializada. Llama a create()',
      );
    }
    return _instance!;
  }
}
