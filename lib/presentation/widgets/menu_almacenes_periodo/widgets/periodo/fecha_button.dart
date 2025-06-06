import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/utils/fecha.dart';

class FechaButton extends StatefulWidget {
  final bool? esFechaInicial;
  final Function(DateTime fecha)? setFecha;
  final DateTime? fechaExistente;

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
  DateTime? selectedDate;
  final Fecha fecha = Fecha();

  @override
  void initState() {
    esFechaInicial = widget.esFechaInicial == true ? true : false;
    super.initState();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await customDatePicker(
      context,
      initialDate:
          selectedDate ??
          widget.fechaExistente ??
          (esFechaInicial ? fecha.ayerDateTime : fecha.hoyDateTime),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        if (widget.setFecha != null) {
          widget.setFecha!(selectedDate!);
        }
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
            ? fecha.crearString(widget.fechaExistente!)
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
