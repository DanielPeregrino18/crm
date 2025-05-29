import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final List<Step> steps;

  // Se puede agregar una función para mostrar un diálogo de confirmación o alguna otra acción
  final Function? onLastStepContinue;

  const CustomStepper({
    super.key,
    required this.steps,
    this.onLastStepContinue,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;

  late List<Step> _steps;

  @override
  void initState() {
    _steps = widget.steps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child:
              _currentStep == 0
                  ? ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Siguiente'),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Atrás'),
                      ),
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          _currentStep == _steps.length
                              ? 'Finalizar'
                              : 'Siguiente',
                        ),
                      ),
                    ],
                  ),
        );
      },
      type: StepperType.vertical,
      steps: _steps.map((Step step) => step).toList(),
      onStepTapped: (int newIndex) {
        setState(() {
          _currentStep = newIndex;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep != _steps.length-1) {
          setState(() {
            _currentStep += 1;
          });
        } else {
          Navigator.pop(context);
          if (widget.onLastStepContinue != null) {
            widget.onLastStepContinue!();
          }
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
    );
  }
}
