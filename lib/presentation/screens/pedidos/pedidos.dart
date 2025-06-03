import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/data/models/almacen_model.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/screens/pedidos/widgets/pedidos_widgets.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/custom_drawer.dart';
import 'package:crm/presentation/widgets/drawer_busqueda.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/menu_almacen_periodo.dart';
import 'package:crm/presentation/widgets/search_bar_clientes.dart';
import 'package:crm/presentation/widgets/search_button.dart';
import 'package:crm/data/models/pedidos/cab_ped_rango_model.dart';
import 'package:crm/presentation/screens/pedidos/widgets/cabs_ped_rango/card_cab_ped_rango.dart';

class Pedidos extends ConsumerStatefulWidget {
  const Pedidos({super.key});

  @override
  ConsumerState<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends ConsumerState<Pedidos> {
  bool isLoading = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void stopLoading() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void guardarAlmacenes(List<Almacen> almacenes) async {
    if (almacenes.isNotEmpty) {
      int i = 1;
      for (Almacen alm in almacenes) {
        AlmacenOB almacenOB = AlmacenOB(
          id_sucursal: alm.id_sucursal,
          id_almacen: alm.id_almacen,
          nombre: alm.nombre,
        );

        bool result = ref.read(almacenesVMProvider).agregarAlmacen(almacenOB);

        if (result == false) {
          debugPrint(
            "Almacen no registrado, id_almacen duplicado: ${almacenOB.id_almacen}",
          );
        } else {
          debugPrint("Guardando almacenes...${i++}/${almacenes.length}");
        }
      }
    } else {
      debugPrint("No hay almacenes para guardar");
    }
    setState(() {
      ref.watch(almacenesVMProvider.notifier).getAllAlmacenesLDB();
    });
  }

  void cargarAlmacenes() async {
    setState(() {
      isLoading = true;
    });

    await ref
        .read(almacenesProvider.notifier)
        .fetchAlmacenes('19cf4bcd-c52c-41bf-9fc8-b1f3d91af2df', 2, 10);

    stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    List<Almacen> almacenes = ref.watch(almacenesProvider);

    final CabsPedRangoVM cabsPedRangoVM = ref.watch(
      cabsPedRangoVMProvider.notifier,
    );

    final SearchController clienteSearchController =
        cabsPedRangoVM.pedidosVM.clienteSearchController;

    final List<Widget> searchBarActions = [
      IconButton(
        onPressed: () {
          clienteSearchController.clear();
        },
        icon: Icon(Icons.clear, color: theme.primary),
      ),
    ];

    final List<CabPedRangoModel>? cabsPedRango =
        ref.watch(cabsPedRangoVMProvider).value;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text('Pedidos', style: TextStyle(color: theme.onPrimary)),
        actions: [
          FittedBox(
            child: IconButton(
              icon: Icon(Icons.search, size: 30.sp),
              tooltip: 'Buscar pedido',
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          IconButton(
            tooltip: 'Nuevo pedido',
            icon: Icon(Icons.add),
            onPressed: () {
              context.go('/pedidos/pedido', extra: true);
            },
          ),
        ],
      ),
      drawer: CustomDrawer(theme: theme),
      endDrawer: DrawerBusqueda(
        title: 'Buscar pedido',
        tabBars: {
          'Por movimiento': BuscarPedidoMovimiento(),
          'Por cliente': BuscarPedidosCliente(),
        },
      ),
      body: ListView(
        children: [
          MenuAlmacenPeriodo(
            setAlmacen: (int id, String nombre) {
              cabsPedRangoVM.pedidosVM.seleccionarAlmacen(id, nombre);
              debugPrint(
                'Id almacén: ${cabsPedRangoVM.pedidosVM.almacenSeleccionado.id}',
              );
            },
            setTipoFecha: (int tipoF) {
              cabsPedRangoVM.pedidosVM.tipoFecha = tipoF;
              debugPrint('Tipo fecha: ${cabsPedRangoVM.pedidosVM.tipoFecha}');
            },
            setFechaInicial: (String fechaI) {
              cabsPedRangoVM.pedidosVM.fechaInicio = fechaI;
              debugPrint(
                'Fecha inicial: ${cabsPedRangoVM.pedidosVM.fechaInicio}',
              );
            },
            setFechaFinal: (String fechaF) {
              cabsPedRangoVM.pedidosVM.fechaFin = fechaF;
              debugPrint('Fecha final: ${cabsPedRangoVM.pedidosVM.fechaFin}');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SearchBarClientes(
                        hint: 'Cliente',
                        actions: searchBarActions,
                        inputController: clienteSearchController,
                        setIdCliente: (id) {
                          cabsPedRangoVM.pedidosVM.idCliente = id;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: SearchButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await cabsPedRangoVM.getCabsPedRango();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : cabsPedRango == null
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: theme.primary,
                            size: 30,
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await cabsPedRangoVM.getCabsPedRango();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                        Text('Sin resultados para mostrar'),
                      ],
                    )
                    : Column(
                      spacing: 10,
                      children: [
                        Text(
                          'Resultados: ${cabsPedRango.length}',
                          style: TextStyle(color: theme.primary),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: cabsPedRango.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardCabPedRango(
                              cabPedRango: cabsPedRango[index],
                              numeroResultado: ++index,
                            );
                          },
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (!isLoading) {
      //       if (almacenes.isEmpty) {
      //         cargarAlmacenes();
      //       } else {
      //         guardarAlmacenes(almacenes);
      //       }
      //     }
      //   },
      //   child: Icon(Icons.storefront),
      // ),
    );
  }
}
