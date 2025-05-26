import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/search_bar_clientes.dart';
class CotizacionBusquedaCliente extends StatelessWidget {
  const CotizacionBusquedaCliente({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 15,
        children: [
          //SearchBarClientes(hint: "Cliente", actions: [], inputController: SearchController()),
          CustomTextField(
            label: "Ordenes de compra",
            isEnabled: true,
            controller: TextEditingController(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Fecha Inicial"),
              TextButton(onPressed: () async {
                var fechaInicio = await customDatePicker(context);
                print(fechaInicio);
              }, child: Text("26/04/2025"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Fecha Fin"),
              TextButton(onPressed: () async {
                var fechaFin = await customDatePicker(context);
                print(fechaFin);
              }, child: Text("26/04/2025"))
            ],
          ),
          CustomTextField(
            label: "Folio",
            isEnabled: true,
            controller: TextEditingController(),
          ),
          CustomButton(onPressed: (){

          }, label: "Buscar")
        ],
      ),
    );
  }
}

