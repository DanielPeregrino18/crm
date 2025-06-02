import 'package:crm/data/models/pedidos/det_ped_mov_model.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/text_bold_normal.dart';
import 'package:flutter/material.dart';
import 'package:crm/presentation/widgets/expandable_card.dart';
import 'package:crm/data/models/pedidos/cab_ped_rango_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCabPedRango extends ConsumerWidget {
  final CabPedRangoModel cabPedRango;

  final int numeroResultado;

  const CardCabPedRango({
    super.key,
    required this.cabPedRango,
    required this.numeroResultado,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    Color estatusColor =
        cabPedRango.ESTATUS == "CANCELADO"
            ? Colors.red.shade800
            : cabPedRango.ESTATUS == "FACTURADO"
            ? Colors.green.shade600
            : Colors.amber.shade600;

    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    String right(dynamic right, bool isDate) {
      return right == null
          ? 'Sin datos'
          : isDate
          ? formatter.format(right)
          : '$right';
    }

    final DetPedMovVM detPedMovVM = ref.watch(detPedMovVMProvider.notifier);
    final DetPedMovModel? detPedMov = ref.watch(detPedMovVMProvider).value;

    return ExpandableCard(
      onTap: () {
        debugPrint('redirección');
      },
      onOpenDetalles: () async {
        await detPedMovVM.getDetPedMov(
          cabPedRango.ID_ALMACEN!,
          cabPedRango.ID_PEDIDO!,
        );
      },
      title: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBoldNormal(
                bold: 'Pedido',
                boldColor: theme.primary,
                normal: right(cabPedRango.ID_PEDIDO, false),
              ),
              TextBoldNormal(
                bold: 'Fecha movimiento',
                normal: right(cabPedRango.FECHA_MOVIMIENTO, true),
              ),
              Text(
                '$numeroResultado',
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: theme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      estatus: Row(
        spacing: 5,
        children: [
          Icon(Icons.info_outline, size: 15.sp, color: estatusColor),
          Text('${cabPedRango.ESTATUS}', style: TextStyle(color: estatusColor)),
        ],
      ),
      expanded: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Código: ${detPedMov?.ID_ARTICULO}'),
          Text('Cantidad: ${detPedMov?.CANTIDAD}'),
          Text('Importe: \$${detPedMov?.IMPORTE}'),
          Text('Descuento: \$${detPedMov?.DESCUENTO}'),
          Text('IVA: \$${detPedMov?.IVA}'),
          Text('Cantidad facturada: ${detPedMov?.CANTIDAD_FACTURADA}'),
          Text('Precio: \$${detPedMov?.Precio}'),
          Text('ID lista: ${detPedMov?.ID_LISTA}'),
          Text('Precio de lista: \$${detPedMov?.PRECIOLISTA}'),
          Text(
            'Fecha requerido: ${formatter.format(detPedMov!.Fecha_Requerido!)}',
          ),
          Text('Es paquete: ${detPedMov.ES_PAQUETE! == true ? 'Si' : 'No'}'),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          TextBoldNormal(
            bold: 'Cliente',
            normal: right(cabPedRango.ID_CLIENTE, false),
          ),
          TextBoldNormal(
            bold: 'Vendedor',
            normal: right(cabPedRango.ID_VENDEDOR, false),
          ),
          TextBoldNormal(
            bold: 'Almacén',
            normal: right(cabPedRango.ID_ALMACEN, false),
          ),
          TextBoldNormal(
            bold: 'Paridad',
            normal: right(cabPedRango.PARIDAD, false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBoldNormal(
                bold: 'F. Registro',
                normal: right(cabPedRango.FECHA_REGISTRO, true),
              ),
              TextBoldNormal(
                bold: 'F. Orden compra',
                normal: right(cabPedRango.FECHA_OC, true),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBoldNormal(
                bold: 'F. Inicio consigna',
                normal: right(cabPedRango.FECHA_INICIOC, true),
              ),
              TextBoldNormal(
                bold: 'F. Fin consigna',
                normal: right(cabPedRango.FECHA_FINC, true),
              ),
            ],
          ),
          TextBoldNormal(
            bold: 'F. Cancelación',
            normal: right(cabPedRango.FECHA_CANCELACION, true),
          ),
        ],
      ),
    );
  }
}
