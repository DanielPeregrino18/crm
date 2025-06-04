import 'package:crm/data/models/cotizaciones/cab_cotizacion.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/cotizciones_vm.dart';
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

class CardCotizacion extends ConsumerStatefulWidget {
  final CabCotizacion cotizacion;


  CardCotizacion({Key? key, required this.cotizacion}) : super(key: key);

  @override
  ConsumerState<CardCotizacion> createState() => _CardCotizacionState();
}

class _CardCotizacionState extends ConsumerState<CardCotizacion> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    var detCotizacion = ref.watch(cotizacionVMProvider).detallesCotizacion;
    return ExpandableCard(
      onOpenDetalles: () async {
         await ref.read(cotizacionVMProvider).buscarDetalleCotizacion(widget.cotizacion.ID_COTIZACION!, widget.cotizacion.ID_ALMACEN!);
         setState(() {});
        },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cotización: ${widget.cotizacion.ID_COTIZACION}",
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Fecha: ${formatter.format(widget.cotizacion.FECHA!)}",
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      expanded: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Text("Articulo", textAlign: TextAlign.center,),
              Text("Cantidad", textAlign: TextAlign.center,),
              Text("Importe", textAlign: TextAlign.center,)
            ]
          ),
          ...detCotizacion.map((e) => 
              TableRow(
                children: [
                  Text("${e.ID_ARTICULO}.-${e.NOMBRE}", textAlign: TextAlign.center),
                  Text(e.CANTIDAD!.toStringAsFixed(2), textAlign: TextAlign.center),
                  Text(e.IMPORTE!.toStringAsFixed(2), textAlign: TextAlign.center)
                ]
              ),
          )
        ],
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
              text: widget.cotizacion.ESTATUS,
              style: TextStyle(
                color:
                    widget.cotizacion.ESTATUS == "CANCELADO"
                        ? Colors.red
                        : widget.cotizacion.ESTATUS == "FACTURADO"
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
            .buscarCotizacionMov(idMov: widget.cotizacion.ID_COTIZACION, idAlm: widget.cotizacion.ID_ALMACEN);
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
            normal: widget.cotizacion.NOMBRE_ALMACEN ?? "",
          ),
          TextBoldNormal(
            bold: "Vendedor",
            normal: widget.cotizacion.NOMBRE_VENDEDOR ?? "",
          ),
          TextBoldNormal(bold: "Cliente", normal: widget.cotizacion.CLIENTE ?? ""),
          TextBoldNormal(bold: "Paridad", normal: "${widget.cotizacion.PARIDAD}"),
          TextBoldNormal(
            bold: "Fecha de cancelacion",
            normal:
                widget.cotizacion.FECHA_CANCELACION == null
                    ? ""
                    : formatter.format(widget.cotizacion.FECHA_CANCELACION!),
          ),
          TextBoldNormal(bold: "Total", normal: "${widget.cotizacion.TOTAL}"),
        ],
      ),
    );
  }
}


/*
Container(
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
      )







      Row(
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre", textAlign: TextAlign.center,),
            ...detCotizacion.map((e) =>
                    Text("${e.ID_ARTICULO}.- Nombre"),
                )
              ]
            ),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Cantidad"),
              ...detCotizacion.map((e) =>
                  Text(e.CANTIDAD!.toStringAsFixed(2)),
              )
            ]
            ),
          ),
          Expanded(
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Importe", textAlign: TextAlign.center,),
              ...detCotizacion.map((e) =>
                  Text(e.IMPORTE!.toStringAsFixed(2)),
              )
            ]
            ),
          ),
        ],
      )
*/