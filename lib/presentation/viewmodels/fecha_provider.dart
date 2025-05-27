import 'package:crm/core/utils/fechas.dart';
import 'package:crm/data/models/tipo_fecha_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fecha_provider.g.dart';

// Tipo de fecha
@riverpod
class TipoFechaSeleccionado extends _$TipoFechaSeleccionado {
  @override
  Future<TipoFecha?> build() async {
    return null;
  }

  Future<void> seleccionarTipoFecha(TipoFecha tipoFecha) async {
    state = AsyncData(tipoFecha);
  }
}

@riverpod
class FechaInicialDateTime extends _$FechaInicialDateTime {
  @override
  Future<DateTime> build() async {
    final DateTime ayerDateTime = Fechas().ayerDateTime;
    return ayerDateTime;
  }
}

@riverpod
class FechaFinalDateTime extends _$FechaFinalDateTime {
  @override
  Future<DateTime> build() async {
    final DateTime hoyDateTime = Fechas().hoyDateTime;
    return hoyDateTime;
  }
}

@riverpod
class FechaInicialString extends _$FechaInicialString {
  @override
  Future<String> build() async {
    final String ayer = Fechas().ayerString();
    return ayer;
  }

  Future<void> seleccionarFechaInicial(DateTime nuevaFecha) async {
    final String fechaInicial = Fechas().crearString(nuevaFecha);
    state = AsyncData(fechaInicial);
  }
}

@riverpod
class FechaFinalString extends _$FechaFinalString {
  @override
  Future<String> build() async {
    final String hoy = Fechas().hoyString();
    return hoy;
  }

  Future<void> seleccionarFechaFinal(DateTime nuevaFecha) async {
    final String fechaFinal = Fechas().crearString(nuevaFecha);
    state = AsyncData(fechaFinal);
  }
}
