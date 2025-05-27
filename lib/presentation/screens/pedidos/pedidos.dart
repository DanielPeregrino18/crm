import 'package:crm/data/models/almacen_model.dart';
import 'package:crm/domain/entities/almacen_ob.dart';
import 'package:crm/presentation/viewmodels/almacenes_vm.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/cotizciones_vm.dart';
import 'package:crm/presentation/widgets/custom_drawer.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/menu_almacen_periodo.dart';
import 'package:crm/presentation/widgets/search_bar_clientes.dart';
import 'package:crm/presentation/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Pedidos extends ConsumerStatefulWidget {
  const Pedidos({super.key});

  @override
  ConsumerState<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends ConsumerState<Pedidos> {
  bool isLoading = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

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

    CotizcionesVM cotizacionVM = ref.watch(cotizacionVMProvider);

    final List<Widget> searchBarActions = [
      IconButton(
        onPressed: () {
          cotizacionVM.clearInputCLiente();
        },
        icon: Icon(Icons.clear, color: theme.primary),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text('Pedidos', style: TextStyle(color: theme.onPrimary)),
        actions: [
          IconButton(
            tooltip: 'Buscar pedido',
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Nuevo pedido',
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(theme: theme),
      body: ListView(
        children: [
          MenuAlmacenPeriodo(theme: theme),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SearchBarClientes(
                        hint: 'Cliente',
                        actions: searchBarActions,
                        inputController: cotizacionVM.clienteController,
                        setIdCliente: (id) {
                          cotizacionVM.idCliente = id;
                        },
                      ),
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
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isLoading) {
            if (almacenes.isEmpty) {
              cargarAlmacenes();
            } else {
              guardarAlmacenes(almacenes);
            }
          }
        },
        child: Icon(Icons.storefront),
      ),
    );
  }
}
