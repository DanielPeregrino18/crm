import 'package:intl/intl.dart';

class Fecha {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateTime hoyDateTime = DateTime.now();
  late String hoyString = dateFormat.format(hoyDateTime);
  late DateTime ayerDateTime = DateTime(
    hoyDateTime.year,
    hoyDateTime.month,
    hoyDateTime.day - 1,
  );
  late String ayerString = dateFormat.format(ayerDateTime);

  String crearString(DateTime dateTime) {
    String string = dateFormat.format(dateTime);
    return string;
  }
}
