import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crm/data/models/pedidos/cab_ped_cliente.dart';
import 'package:crm/presentation/widgets/expandable_card.dart';
import 'package:crm/presentation/widgets/text_bold_normal.dart';

class CardCabPedCliente extends StatelessWidget {
  final CabPedCliente cabPedCliente;

  const CardCabPedCliente({super.key, required this.cabPedCliente});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return ExpandableCard(
      onTap: () {
        debugPrint('redirección');
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
      estatus: Text.rich(
        TextSpan(
          text: "Estatus: ",
          children: [
            TextSpan(
              text: cabPedCliente.estatus,
              style: TextStyle(
                color:
                    cabPedCliente.estatus == "CANCELADO"
                        ? Colors.red.shade800
                        : cabPedCliente.estatus == "FACTURADO"
                        ? Colors.green.shade600
                        : Colors.amber.shade600,
              ),
            ),
          ],
        ),
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
