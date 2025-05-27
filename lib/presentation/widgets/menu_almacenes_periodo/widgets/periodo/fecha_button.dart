import 'package:crm/presentation/viewmodels/fecha_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FechaButton extends ConsumerStatefulWidget {
  const FechaButton({super.key, required this.esPrimeraFecha});

  final bool esPrimeraFecha;

  @override
  ConsumerState createState() => _FechaState();
}

class _FechaState extends ConsumerState<FechaButton> {
  late final bool _esPrimeraFecha;

  late final hoyDateTime = ref.read(fechaFinalDateTimeProvider);

  late final ayerDateTime = ref.read(fechaInicialDateTimeProvider);

  late final hoyString = ref.watch(fechaFinalStringProvider);

  late final ayerString = ref.watch(fechaInicialStringProvider);

  DateTime? selectedDate;

  @override
  void initState() {
    _esPrimeraFecha = widget.esPrimeraFecha;
    super.initState();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _esPrimeraFecha ? ayerDateTime.value : hoyDateTime.value,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      _esPrimeraFecha
          ? ref
              .read(fechaInicialStringProvider.notifier)
              .seleccionarFechaInicial(selectedDate!)
          : ref
              .read(fechaFinalStringProvider.notifier)
              .seleccionarFechaFinal(selectedDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        selectedDate != null
            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
            : _esPrimeraFecha
            ? '${ayerString.value}'
            : '${hoyString.value}',
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
