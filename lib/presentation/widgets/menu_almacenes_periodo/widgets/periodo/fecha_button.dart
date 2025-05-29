import 'package:flutter/material.dart';
import 'package:crm/core/utils/fechas.dart';

class FechaButton extends StatefulWidget {
  final Function(String fechaInicial)? setFechaInicial;

  final Function(String fechaFinal)? setFechaFinal;

  const FechaButton({super.key, this.setFechaInicial, this.setFechaFinal});

  @override
  State createState() => _FechaState();
}

class _FechaState extends State<FechaButton> {
  late bool esPrimeraFecha;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    esPrimeraFecha = widget.setFechaInicial != null ? true : false;
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          widget.setFechaInicial == null
              ? Fechas().ayerDateTime
              : DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      esPrimeraFecha
          ? widget.setFechaInicial!(Fechas().crearString(selectedDate!))
          : widget.setFechaFinal!(Fechas().crearString(selectedDate!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        selectedDate != null
            ? Fechas().crearString(selectedDate!)
            : esPrimeraFecha
            ? Fechas().ayerString()
            : Fechas().hoyString(),
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
