import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/features/pedido/presentation/widgets/cab_ped_cliente/cabs_ped_cliente_results.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:crm/features/pedido/presentation/manager/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/almacenes_drop_down_menu.dart';

class BuscarPedidosCliente extends ConsumerWidget {
  const BuscarPedidosCliente({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final TextStyle textStyle = TextStyle(
      color: theme.primary,
      fontWeight: FontWeight.w600,
    );

    final CabsPedClienteVM getCabsPedClienteVM = ref.watch(
      cabsPedClienteVMProvider.notifier,
    );

    void mostrarResultados() {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return CabsPedClienteResults();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(
            setAlmacen: (int id) {
              getCabsPedClienteVM.idAlmacen = id;
              debugPrint('Id: Almacén: ${getCabsPedClienteVM.idAlmacen}');
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fecha inicial', style: textStyle),
              FechaButton(
                esFechaInicial: true,
                setFecha: (DateTime fechaI) {
                  getCabsPedClienteVM.pedidosVM.fechaInicio = fecha.crearString(
                    fechaI,
                  );
                  debugPrint(
                    'Fecha inicial: ${getCabsPedClienteVM.pedidosVM.fechaInicio}',
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fecha final', style: textStyle),
              FechaButton(
                setFecha: (DateTime fechaF) {
                  getCabsPedClienteVM.pedidosVM.fechaFin = fecha.crearString(
                    fechaF,
                  );
                  debugPrint(
                    'Fecha final: ${getCabsPedClienteVM.pedidosVM.fechaFin}',
                  );
                },
              ),
            ],
          ),
          CustomTextField(
            label: 'Cliente',
            isEnabled: true,
            controller: getCabsPedClienteVM.clienteController,
          ),
          CustomTextField(
            label: 'Ordenes de compra',
            isEnabled: true,
            controller: getCabsPedClienteVM.ordenCompraController,
          ),
          CustomTextField(
            label: 'Folio',
            textInputType: TextInputType.number,
            textInputFormatters:
                getCabsPedClienteVM.pedidosVM.numberTextInputFormatter,
            isEnabled: true,
            controller: getCabsPedClienteVM.folioController,
          ),
          CustomButton(
            label: 'Buscar',
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primary,
                      backgroundColor: theme.primary.withAlpha(95),
                    ),
                  );
                },
              );
              bool result = await getCabsPedClienteVM.getCabsPedCliente();
              if (result) {
                Navigator.of(context).pop();
                mostrarResultados();
              }
            },
          ),
        ],
      ),
    );
  }
}
