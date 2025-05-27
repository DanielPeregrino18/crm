import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/viewmodels/pedidos/pedidos_vm.dart';
import 'package:crm/presentation/widgets/almacenes_drop_down_menu.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuscarPedidoMovimiento extends ConsumerWidget {
  const BuscarPedidoMovimiento({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final almSeleccionado = ref.watch(almacenSeleccionadoProvider);
    final controller = ref.watch(movimientoControllerProvider);
    final buscarPedMovVM = ref.watch(getPedidoProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(),
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
            onPressed: () {
              buscarPedMovVM.getPedido(
                almSeleccionado.value == null ? 0 : almSeleccionado.value!.id_almacen,
                int.parse(controller.text),
                "19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df",
                2,
                10,
              );
            },
          ),
        ],
      ),
    );
  }
}
