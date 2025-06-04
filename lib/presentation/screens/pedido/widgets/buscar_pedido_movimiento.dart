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
    final ColorScheme theme = Theme.of(context).colorScheme;

    CabPedMovVM cabPedMovVM = ref.watch(cabPedMovVMProvider.notifier);

    TextEditingController controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          AlmacenesDropDownMenu(
            setAlmacen: (int id) {
              cabPedMovVM.idAlmacen = id;
              debugPrint('Id Almacén: ${cabPedMovVM.idAlmacen}');
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
                bool result = await cabPedMovVM.getCabPedMov(
                  cabPedMovVM.idAlmacen,
                  int.parse(controller.text),
                );
                if (result) {
                  Navigator.pop(context);
                  context.go('/pedido/nuevo_detalle_pedido');
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
