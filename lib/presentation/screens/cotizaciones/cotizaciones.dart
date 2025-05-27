import 'package:crm/presentation/screens/cotizaciones/widgets/card_cotizacion.dart';
import 'package:crm/presentation/screens/cotizaciones/widgets/cotizacion_busqueda_cliente.dart';
import 'package:crm/presentation/screens/cotizaciones/widgets/cotizacion_busqueda_movimiento.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/cotizciones_vm.dart';
import 'package:crm/presentation/widgets/custom_drawer.dart';
import 'package:crm/presentation/widgets/drawer_busqueda.dart';
import 'package:crm/presentation/widgets/search_bar_clientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/search_button.dart';

class Cotizaciones extends ConsumerStatefulWidget {
  Cotizaciones({Key? key}) : super(key: key);

  @override
  ConsumerState<Cotizaciones> createState() => _CotizacionesState();
}

class _CotizacionesState extends ConsumerState<Cotizaciones> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    var cotizacionVM = ref.watch(cotizacionVMProvider);
    var theme = Theme.of(context).colorScheme;

    final List<Widget> searchBarActions = [
      IconButton(
        onPressed: () {
          cotizacionVM.clearInputCLiente();
        },
        icon: Icon(Icons.clear, color: theme.primary),
      ),
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            "Diseño prueba",
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20.sp),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: theme.onPrimary),
        actions: [
          FittedBox(
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.search, color: Colors.white, size: 30.sp),
            ),
          ),
          FittedBox(
            child: IconButton(
              onPressed: () {
                //context.go("/crear");
              },
              icon: Icon(Icons.note_add, color: Colors.white, size: 30.sp),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(theme: theme),
      body: Padding(
          padding:EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                      flex: 3,
                      child: SearchBarClientes(hint: "Cliente", actions: searchBarActions, inputController: cotizacionVM.clienteController, setIdCliente: (id) {
                        cotizacionVM.idCliente = id;
                      },)
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56,
                      child: SearchButton(
                        onPressed: () async {
                          await cotizacionVM.buscarCotizacionesRango();
                          setState(() {});
                          },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 20,),
              Expanded(
                child: ListView.builder(
                    itemCount: cotizacionVM.cotizaciones.length,
                    itemBuilder: (context, index) {
                      return CardCotizacion(cotizacion: cotizacionVM.cotizaciones[index]);
                    },
                ),
              )
            ],
          ),
      ),
      endDrawer: DrawerBusqueda(
        title: "Busqueda",
        tabBars: {
          "Movimiento": CotizacionBusquedaMovimiento(),
          "Cliente": CotizacionBusquedaCliente(),
        },
      ),
    );
  }
}
