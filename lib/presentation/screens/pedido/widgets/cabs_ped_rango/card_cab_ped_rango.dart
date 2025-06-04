import 'package:crm/data/models/pedidos/det_ped_mov_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/presentation/widgets/text_bold_normal.dart';
import 'package:crm/presentation/widgets/expandable_card.dart';
import 'package:crm/data/models/pedidos/cab_ped_rango_model.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';

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
      return right == null || right == ""
          ? 'Sin datos'
          : isDate
          ? formatter.format(right)
          : '$right';
    }

    final DetPedMovVM detPedMovVM = ref.watch(detPedMovVMProvider.notifier);
    final List<DetPedMovModel>? detPedMov =
        ref.watch(detPedMovVMProvider).value?[cabPedRango.ID_PEDIDO];
    final CabPedMovVM cabPedMovVM = ref.watch(cabPedMovVMProvider.notifier);

    final NumberFormat numberFormat = NumberFormat(",##0.##");

    String granTotal(
      double cantidad,
      double importe,
      double descuento,
      double ieps,
      double iva,
      double ivaRetenido,
    ) {
      double subtotal = cantidad * importe;
      double granTotal = subtotal - descuento + ieps + iva - ivaRetenido;
      return numberFormat.format(granTotal);
    }

    return ExpandableCard(
      onTap: () async {
        if (cabPedRango.ID_ALMACEN != null && cabPedRango.ID_PEDIDO != null) {
          bool result = await cabPedMovVM.getCabPedMov(
            cabPedRango.ID_ALMACEN!,
            cabPedRango.ID_PEDIDO!,
          );
          if (result) context.go('/pedido/nuevo_detalle_pedido');
        }
      },
      onOpenDetalles: () async {
        if (detPedMov == null &&
            cabPedRango.ID_ALMACEN != null &&
            cabPedRango.ID_PEDIDO != null) {
          await detPedMovVM.getDetPedMov(
            cabPedRango.ID_ALMACEN!,
            cabPedRango.ID_PEDIDO!,
          );
        }
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
          Text(
            right(cabPedRango.ESTATUS, false),
            style: TextStyle(color: estatusColor),
          ),
        ],
      ),
      expanded:
          detPedMov == null
              ? Text('Sin datos')
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                child: DataTable(
                  columnSpacing: 10,
                  columns: [
                    DataColumn(
                      label: Text('Código'),
                      numeric: true,
                      headingRowAlignment: MainAxisAlignment.center,
                    ),
                    DataColumn(
                      label: Text('Nombre'),
                      headingRowAlignment: MainAxisAlignment.center,
                    ),
                    DataColumn(
                      label: Text('Cantidad'),
                      numeric: true,
                      headingRowAlignment: MainAxisAlignment.center,
                    ),
                    DataColumn(
                      label: Text('Total'),
                      numeric: true,
                      headingRowAlignment: MainAxisAlignment.center,
                    ),
                  ],
                  rows:
                      detPedMov.map((articulo) {
                        return DataRow(
                          cells: [
                            DataCell(Text(right(articulo.ID_ARTICULO, false))),
                            DataCell(Text(right(articulo.NOMBRE, false))),
                            DataCell(Text(right(articulo.CANTIDAD, false))),
                            DataCell(
                              Text(
                                '\$${granTotal(articulo.CANTIDAD!, articulo.IMPORTE!, articulo.DESCUENTO!, articulo.IEPS!, articulo.IVA!, articulo.IVA_RETENIDO!)}',
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          TextBoldNormal(
            bold: 'Cliente',
            normal: right(cabPedRango.Nombre, false),
          ),
          TextBoldNormal(
            bold: 'Vendedor',
            normal: right(cabPedRango.NOMBRE_VENDEDOR, false),
          ),
          TextBoldNormal(
            bold: 'Almacén',
            normal: right(cabPedRango.NOMBRE_ALMACEN, false),
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
