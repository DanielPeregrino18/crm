import 'package:crm/presentation/viewmodels/cotizaciones/busqueda_cot_clie_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/DI/dependencias.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/search_bar_clientes.dart';
import 'card_cotizacion_movimiento.dart';

class CotizacionBusquedaCliente extends ConsumerStatefulWidget {
  CotizacionBusquedaCliente({super.key});

  @override
  ConsumerState<CotizacionBusquedaCliente> createState() =>
      _CotizacionBusquedaClienteState();
}

class _CotizacionBusquedaClienteState
    extends ConsumerState<CotizacionBusquedaCliente> {
  @override
  Widget build(BuildContext context) {
    var busquedaCotClieVM = ref.watch(busquedaCotClieVMProvider.notifier).state;
    var theme = Theme.of(context).colorScheme;

    final List<Widget> searchBarActions = [
      IconButton(
        onPressed: () {
          busquedaCotClieVM.clearInputCliente();
        },
        icon: Icon(Icons.clear, color: theme.primary),
      ),
    ];
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 15,
        children: [
          SearchBarClientes(
            hint: "Cliente",
            actions: searchBarActions,
            inputController: busquedaCotClieVM.clienteController,
            setIdCliente: (int id) { print(id); },
          ),
          CustomTextField(
            label: "Ordenes de compra",
            isEnabled: true,
            controller: busquedaCotClieVM.ordenCompraController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Fecha Inicial"),
              TextButton(
                onPressed: () async {
                  var fechaInicio = await customDatePicker(context);
                  if (fechaInicio != null) {
                    busquedaCotClieVM.fechaInicial = fechaInicio;
                    setState(() {});
                  }
                },
                child: Text(
                  ref
                      .read(formatterProvider)
                      .format(busquedaCotClieVM.fechaInicial),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Fecha Fin"),
              TextButton(
                onPressed: () async {
                  var fechaFin = await customDatePicker(context);
                  if (fechaFin != null) {
                    busquedaCotClieVM.fechaFin = fechaFin;
                    setState(() {});
                  }
                },
                child: Text(
                  ref
                      .read(formatterProvider)
                      .format(busquedaCotClieVM.fechaFin),
                ),
              ),
            ],
          ),
          CustomTextField(
            label: "Folio",
            isEnabled: true,
            controller: busquedaCotClieVM.folioController,
          ),
          CustomButton(
            onPressed: () async {
              var mostrarCotizaciones = await busquedaCotClieVM.buscarCotizaciones();
              if(mostrarCotizaciones){
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: busquedaCotClieVM.cotizacionesCliente.length,
                          itemBuilder: (context, index) {
                            return CardCotizacionMovimiento(cotCliente: busquedaCotClieVM.cotizacionesCliente[index],);
                          },
                        ),
                      ),
                    );
                  },
                );
              }else {
                Fluttertoast.showToast(
                    msg: "No hay elementos para mostrar.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    textColor: Colors.white,
                    fontSize: 18.0
                );
              }
            },
            label: "Buscar",
          ),
        ],
      ),
    );
  }
}
