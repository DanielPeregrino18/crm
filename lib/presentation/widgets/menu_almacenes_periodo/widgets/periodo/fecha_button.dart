import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/utils/fechas.dart';

class FechaButton extends StatefulWidget {
  final bool? esFechaInicial;

  final Function(String fecha)? setFecha;

  final String? fechaExistente;

  const FechaButton({
    super.key,
    this.esFechaInicial,
    this.setFecha,
    this.fechaExistente,
  });

  @override
  State createState() => _FechaState();
}

class _FechaState extends State<FechaButton> {
  late bool esFechaInicial;

  @override
  void initState() {
    esFechaInicial = widget.esFechaInicial == true ? true : false;
    super.initState();
  }

  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await customDatePicker(
      context,
      initialDate: esFechaInicial ? Fechas().ayerDateTime : DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      widget.setFecha!(Fechas().crearString(selectedDate!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        selectedDate !=
                null // Hay alguna fecha seleccionada?
            ? Fechas().crearString(
              selectedDate!,
            ) // Muestra la fecha seleccionada
            : widget.fechaExistente !=
                null // Se pasó una fecha existente?
            ? widget.fechaExistente! // Muestra la fecha existente
            : esFechaInicial // Es una fecha inicial?
            ? Fechas()
                .ayerString() // Fecha del día anterior
            : Fechas().hoyString(), // Fecha día actual
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      icon: Icon(Icons.date_range, color: Colors.black),
      onPressed: () {
        _selectDate();
      },
    );
  }
}
