import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/almacenes_drop_down_menu.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';

class BuscarPedidoMovimiento extends ConsumerWidget {
  const BuscarPedidoMovimiento({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CabPedMovVM cabPedMovVM = ref.watch(cabPedMovVMProvider.notifier);

    TextEditingController controller = cabPedMovVM.movimientoController;

    late bool result;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(
            setAlmacen: (int id, String nombre) {
              cabPedMovVM.pedidosVM.seleccionarAlmacen(id, nombre);
              debugPrint('Id: Almacén: ${cabPedMovVM.pedidosVM.almacenSeleccionado.id}');
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
              if (controller.text.isEmpty) {
                debugPrint('No se ha ingresado el movimiento');
                // TODO: Implementar un indicador en pantalla
              } else {
                result = await cabPedMovVM.getCabPedMov(
                  int.parse(controller.text),
                );
                if (result) {
                  // Navigator.pop(context); // Se puede cerrar el campo de búsqueda por movimiento al encontrar el pedido
                  context.go('/pedidos/pedido', extra: false);
                }
                // TODO: Implementar un indicador en pantalla en caso de no encontrar el pedido
              }
            },
          ),
        ],
      ),
    );
  }
}
