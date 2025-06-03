import 'package:crm/data/models/cab_cotizacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../viewmodels/cotizaciones/busqueda_cot_mov_vm.dart';
import '../../../widgets/expandable_card.dart';
import '../../../widgets/text_bold_normal.dart';

class CardCotizacion extends ConsumerWidget {
  final CabCotizacion cotizacion;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  CardCotizacion({Key? key, required this.cotizacion}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandableCard(
      onOpenDetalles: ()async{
        //print("object");
        //await Future.delayed(const Duration(seconds: 2));
        },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cotización: ${cotizacion.ID_COTIZACION}",
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Fecha: ${formatter.format(cotizacion.FECHA!)}",
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      expanded: Container(
        color: Colors.white,
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Wrap(
              spacing: 15.w,
              runSpacing: 10.h,
              children: [
                TextBoldNormal(bold: "Código", normal: "43"),
                TextBoldNormal(bold: "Artículo", normal: "Creditos"),
                TextBoldNormal(bold: "Unidad", normal: "PZA"),
                TextBoldNormal(bold: "Marca", normal: "SIN MARCA"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Table(
                border: TableBorder(
                  verticalInside: BorderSide(color: Colors.grey),
                  top: BorderSide(color: Colors.grey),
                ),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cant:",
                              style: GoogleFonts.montserrat(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "1,000.0",
                              style: GoogleFonts.montserrat(fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Desc:",
                              style: GoogleFonts.montserrat(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "0.00",
                              style: GoogleFonts.montserrat(fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Importe:",
                              style: GoogleFonts.montserrat(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "7,520.00",
                              style: GoogleFonts.montserrat(fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "%IVA:",
                              style: GoogleFonts.montserrat(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "16.0",
                              style: GoogleFonts.montserrat(fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      estatus: Text.rich(
        TextSpan(
          text: "Estatus: ",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
          children: [
            TextSpan(
              text: cotizacion.ESTATUS,
              style: TextStyle(
                color:
                    cotizacion.ESTATUS == "CANCELADO"
                        ? Colors.red
                        : cotizacion.ESTATUS == "FACTURADO"
                        ? Colors.green
                        : Colors.amber,
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        bool seEncontroCot = await ref
            .read(busquedaCotMovVMProvider)
            .buscarCotizacionMov(idMov: cotizacion.ID_COTIZACION);
        if (seEncontroCot) {
          context.go("/vercotizacion");
        } else {
          Fluttertoast.showToast(
            msg: "No se pudo obtener la cotización.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            textColor: Colors.white,
            fontSize: 18.0,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBoldNormal(
            bold: "Almacén",
            normal: cotizacion.NOMBRE_ALMACEN ?? "",
          ),
          TextBoldNormal(
            bold: "Vendedor",
            normal: cotizacion.NOMBRE_VENDEDOR ?? "",
          ),
          TextBoldNormal(bold: "Cliente", normal: cotizacion.CLIENTE ?? ""),
          TextBoldNormal(bold: "Paridad", normal: "${cotizacion.PARIDAD}"),
          TextBoldNormal(
            bold: "Fecha de cancelacion",
            normal:
                cotizacion.FECHA_CANCELACION == null
                    ? ""
                    : formatter.format(cotizacion.FECHA_CANCELACION!),
          ),
          TextBoldNormal(bold: "Total", normal: "${cotizacion.TOTAL}"),
        ],
      ),
    );
  }
}
