import 'package:flutter/material.dart';

Future<TimeOfDay?> customHourPicker(
  BuildContext context,
  int hora,
  int minutos,
  String titulo,
) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: hora, minute: minutos),
    errorInvalidText: "Hora invalida",
    minuteLabelText: "Minutos",
    hourLabelText: "Hora",
    cancelText: "Cancelar",
    confirmText: "Aceptar",
    helpText: titulo,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    builder: (context, child) {
      return Theme(
        data: Theme.of(
          context,
        ).copyWith(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        ),
      );
    },
  );
}

Future<DateTime?> customDatePicker(
  BuildContext context, {
  DateTime? initialDate,
}) {
  return showDatePicker(
    barrierLabel: "Fecha",
    fieldLabelText: "Fecha",
    cancelText: "Cancelar",
    confirmText: "Seleccionar",
    helpText: "Seleccionar Fecha",
    errorInvalidText: "Fecha invalida",
    errorFormatText: "Formato invalido",
    locale: const Locale("es", "MX"),
    context: context,
    firstDate: DateTime(2015),
    lastDate: DateTime.now(),
    initialDate: initialDate ?? DateTime.now(),
  );
}

/*
  en Material APP
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
  ],
*/
