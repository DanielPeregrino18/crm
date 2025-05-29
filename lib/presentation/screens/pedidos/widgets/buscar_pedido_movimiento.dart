import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crm/presentation/viewmodels/pedidos/pedidos_vm.dart';
import 'package:crm/presentation/widgets/almacenes_drop_down_menu.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BuscarPedidoMovimiento extends ConsumerWidget {
  const BuscarPedidoMovimiento({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PedidosVM pedidosVM = ref.watch(pedidosVMProvider);
    int idAlmacen = ref.watch(pedidosVMProvider).almacenSeleccionado.id;
    GetPedido buscarPedMovVM = ref.watch(getPedidoProvider.notifier);
    TextEditingController controller = buscarPedMovVM.movimientoController;
    late bool result;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(
            setAlmacen: (int id, String nombre) {
              pedidosVM.seleccionarAlmacen(id, nombre);
              debugPrint('Id: Almacén: ${pedidosVM.almacenSeleccionado.id}');
            },
          ),
          CustomTextField(
            label: "Movimiento",
            textInputType: TextInputType.number,
            textInputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            isEnabled: true,
            controller: controller,
          ),
          CustomButton(
            label: "Buscar",
            onPressed: () async {
              result = await buscarPedMovVM.getPedido(
                idAlmacen,
                int.parse(controller.text),
                "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
                2,
                10,
              );
              if (result) {
                // Navigator.pop(context); // Se puede cerrar el campo de búsqueda por movimiento al encontrar el pedido
                context.go('/pedidos/pedido', extra: false);
              }
            },
          ),
        ],
      ),
    );
  }
}
