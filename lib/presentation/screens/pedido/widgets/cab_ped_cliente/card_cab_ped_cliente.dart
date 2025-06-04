import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:crm/data/models/pedidos/cab_ped_cliente.dart';
import 'package:crm/presentation/widgets/expandable_card.dart';
import 'package:crm/presentation/widgets/text_bold_normal.dart';

class CardCabPedCliente extends ConsumerWidget {
  final CabPedCliente cabPedCliente;

  const CardCabPedCliente({super.key, required this.cabPedCliente});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final Color estatusColor =
        cabPedCliente.estatus == "CANCELADO"
            ? Colors.red.shade800
            : cabPedCliente.estatus == "FACTURADO"
            ? Colors.green.shade600
            : Colors.amber.shade600;

    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    final CabPedMovVM cabPedMovVM = ref.watch(cabPedMovVMProvider.notifier);

    return ExpandableCard(
      onTap: () async {
        if (cabPedCliente.Clave != null) {
          bool result = await cabPedMovVM.getCabPedMov(
            int.parse(cabPedCliente.Clave!.split('-')[0]),
            int.parse(cabPedCliente.Clave!.split('-')[1]),
          );
          if (result) context.go('/pedido/nuevo_detalle_pedido');
        }
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBoldNormal(bold: 'Clave', normal: cabPedCliente.Clave!),
          TextBoldNormal(
            bold: 'Fecha',
            normal: formatter.format(cabPedCliente.Fecha!),
          ),
        ],
      ),
      estatus: Row(
        spacing: 5,
        children: [
          Icon(Icons.info_outline, size: 15.sp, color: estatusColor),
          Text(
            '${cabPedCliente.estatus}',
            style: TextStyle(color: estatusColor),
          ),
        ],
      ),
      expanded: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: theme.primary.withAlpha(15),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            TextBoldNormal(
              bold: 'Orden de compra',
              normal:
                  cabPedCliente.OrdenCompra!.isNotEmpty
                      ? cabPedCliente.OrdenCompra!
                      : 'Sin orden de compra',
            ),
            TextBoldNormal(
              bold: 'Observaciones',
              normal:
                  cabPedCliente.OrdenCompra!.isNotEmpty
                      ? cabPedCliente.Observaciones!
                      : 'Sin observaciones',
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          TextBoldNormal(bold: 'Nombre', normal: cabPedCliente.Nombre!),
          TextBoldNormal(
            bold: 'Total',
            normal: '\$${cabPedCliente.Total!.trim()}',
          ),
        ],
      ),
    );
  }
}
