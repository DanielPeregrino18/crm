import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/utils/fecha.dart';

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

  final Fecha fecha = Fecha();

  @override
  void initState() {
    esFechaInicial = widget.esFechaInicial == true ? true : false;
    super.initState();
  }

  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await customDatePicker(
      context,
      initialDate: esFechaInicial ? fecha.ayerDateTime : DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.setFecha!(fecha.crearString(selectedDate!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        selectedDate != null
            ? fecha.crearString(selectedDate!)
            : widget.fechaExistente != null
            ? widget.fechaExistente!
            : esFechaInicial
            ? fecha.ayerString
            : fecha.hoyString,
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
