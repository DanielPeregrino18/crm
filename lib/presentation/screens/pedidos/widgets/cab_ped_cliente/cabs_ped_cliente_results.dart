import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/presentation/screens/pedidos/widgets/cab_ped_cliente/card_cab_ped_cliente.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';

class CabsPedClienteResults extends ConsumerWidget {
  const CabsPedClienteResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final cabsPedidoClienteVM = ref.watch(cabsPedClienteVMProvider);

    return Scaffold(
      backgroundColor: theme.primary.withAlpha(15),
      appBar: AppBar(
        backgroundColor: theme.primary.withAlpha(30),
        iconTheme: IconThemeData(color: theme.primary),
        title: Text('Resultados', style: TextStyle(color: theme.primary)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: cabsPedidoClienteVM.value?.length,
          itemBuilder: (BuildContext context, int index) {
            return CardCabPedCliente(
              cabPedCliente: cabsPedidoClienteVM.value![index],
            );
          },
        ),
      ),
    );
  }
}
