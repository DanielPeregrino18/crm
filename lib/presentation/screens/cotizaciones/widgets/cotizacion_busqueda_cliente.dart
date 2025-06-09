import 'package:crm/presentation/viewmodels/cotizaciones/busqueda_cot_clie_vm.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/cotizciones_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/DI/dependencias.dart';
import '../../../viewmodels/cliente_vm.dart';
import '../../../widgets/almacenes_drop_down_menu.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_search_bar.dart';
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
    var busquedaCotClieVM = ref.watch(busquedaCotClieVMProvider);
    var theme = Theme.of(context).colorScheme;

    final List<Widget> searchBarActions = [
      IconButton(
        onPressed: () {
          busquedaCotClieVM.clearInputCliente();
        },
        icon: Icon(Icons.clear, color: theme.primary),
      ),
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 15,
          children: [
            AlmacenesDropDownMenu(
              setAlmacen: (int id) {
                busquedaCotClieVM.idAlmacen = id;
              },
            ),
            CustomSearchBar(
                controller: busquedaCotClieVM.clienteController,
                focusNode: busquedaCotClieVM.focusCliente,
                itemBuilder: (context, value) {
                  return ListTile(
                    title: Text("${value.idCliente}.- ${value.nombre}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(value.razonSocial),
                        Text(value.rfc)
                      ],
                    ),
                  );
                },
                sugerencias: (search) {
                  return ref
                      .read(clienteVMProvider)
                      .getClientesFiltro(search);
                },
                onSelect: (value) {
                  busquedaCotClieVM.setCliente(value);
                },
                onClean: () {
                  busquedaCotClieVM.idCliente = 0;
                },
                label: "Cliente"
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
                    busquedaCotClieVM.setFechaInicial(await customDatePicker(context, initialDate: busquedaCotClieVM.fechaInicial));
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
                    busquedaCotClieVM.setFechaFin(await customDatePicker(context, initialDate: busquedaCotClieVM.fechaFin));
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
      ),
    );
  }
}
