import 'package:flutter/material.dart';

import '../../../widgets/custom_text_field.dart';

class CotizacionBusquedaMovimiento extends StatelessWidget {
  const CotizacionBusquedaMovimiento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          CustomTextField(
            label: "Movimiento",
            isEnabled: true,
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
