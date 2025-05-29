import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/presentation/viewmodels/pedidos/pedidos_vm.dart';
import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/presentation/widgets/almacenes_drop_down_menu.dart';

class BuscarPedidosCliente extends ConsumerWidget {
  const BuscarPedidosCliente({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    TextStyle textStyle = TextStyle(
      color: theme.primary,
      fontWeight: FontWeight.w600,
    );

    PedidosVM pedidosVM = ref.watch(pedidosVMProvider);
    int idAlmacen = pedidosVM.almacenSeleccionado.id;
    String fechaInicial = pedidosVM.fechaInicial;
    String fechaFinal = pedidosVM.fechaFinal;

    GetCabsPedCliente getCabsPedCliente = ref.watch(
      getCabsPedClienteProvider.notifier,
    );
    TextEditingController clienteController =
        getCabsPedCliente.clienteController;
    TextEditingController ordenesCompraController =
        getCabsPedCliente.ordenesCompraController;
    TextEditingController folioController = getCabsPedCliente.folioController;

    late bool result;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(
            setAlmacen: (int id, String nombre) {
              pedidosVM.almacenSeleccionado = AlmacenSeleccionado(
                id: id,
                nombre: nombre,
              );
              debugPrint('Id: Almacén: ${pedidosVM.almacenSeleccionado.id}');
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fecha inicial', style: textStyle),
              FechaButton(
                esFechaInicial: true,
                setFecha: (String fechaI) {
                  pedidosVM.fechaInicial = fechaI;
                  debugPrint('Fecha inicial: ${pedidosVM.fechaInicial}');
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fecha final', style: textStyle),
              FechaButton(
                setFecha: (String fechaF) {
                  pedidosVM.fechaFinal = fechaF;
                  debugPrint('Fecha final: ${pedidosVM.fechaFinal}');
                },
              ),
            ],
          ),
          CustomTextField(
            label: 'Cliente',
            isEnabled: true,
            controller: clienteController,
          ),
          CustomTextField(
            label: 'Ordenes de compra',
            isEnabled: true,
            controller: ordenesCompraController,
          ),
          CustomTextField(
            label: 'Folio',
            isEnabled: true,
            controller: folioController,
          ),
          CustomButton(
            label: 'Buscar',
            onPressed: () async {
              result = await getCabsPedCliente.getCabsPedCliente(
                idAlmacen,
                int.parse(clienteController.text), // 0
                fechaInicial, // '01/01/2025'
                fechaFinal, // '29/05/2025',
                int.parse(folioController.text), // 0
                ' ',
                "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
                2,
                10,
              );
              print(result);
            },
          ),
        ],
      ),
    );
  }
}
