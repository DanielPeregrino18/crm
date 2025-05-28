import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/data/models/cab_cotizacion_cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/expandable_card.dart';
import '../../../widgets/text_bold_normal.dart';

class CardCotizacionMovimiento extends ConsumerWidget {
  final CabCotizacionCliente cotCliente;
  const CardCotizacionMovimiento({
    super.key, required this.cotCliente,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandableCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBoldNormal(bold: "Clave", normal: cotCliente.Clave!),
          TextBoldNormal(bold: "fecha", normal: ref.read(formatterProvider).format(cotCliente.Fecha!))
        ],
      ),
      expanded: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBoldNormal(bold: "Orden de compra", normal: cotCliente.OrdenCompra??""),
          TextBoldNormal(bold: "Observaciones", normal: cotCliente.Observaciones??"")
        ],
      ),
      estatus:  Text.rich(
        TextSpan(
          text: "Estatus: ",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
          children: [
            TextSpan(
              text: cotCliente.estatus!,
              style: TextStyle(color: cotCliente.estatus == "FACTURADO" ? Colors.green : cotCliente.estatus == "COTIZADO" ? Colors.amber : Colors.red),
            ),
          ],
        ),
      ),
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBoldNormal(bold: "Nombre", normal: cotCliente.Nombre??""),
          TextBoldNormal(bold: "Total", normal: cotCliente.Total??"0.0"),
        ],
      ),
    );
  }
}
