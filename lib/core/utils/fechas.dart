class Fechas {
  final DateTime hoyDateTime = DateTime.now();
  late final DateTime ayerDateTime = DateTime(
    hoyDateTime.year,
    hoyDateTime.month,
    hoyDateTime.day - 1,
  );

  String hoyString() {
    final String hoy =
        '${hoyDateTime.day}/${hoyDateTime.month}/${hoyDateTime.year}';
    return hoy;
  }

  String ayerString() {
    final String ayer =
        '${ayerDateTime.day}/${ayerDateTime.month}/${ayerDateTime.year}';
    return ayer;
  }

  DateTime crearDateTime(int dia, int mes, int anio) {
    DateTime dateTime = DateTime(anio, mes, dia);
    return dateTime;
  }

  String crearString(DateTime dateTime) {
    String string = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return string;
  }
}
