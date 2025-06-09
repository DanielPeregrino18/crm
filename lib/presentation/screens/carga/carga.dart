import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:crm/domain/entities/lista_precios_ob.dart';
import 'package:crm/presentation/viewmodels/colecciones/lista_precios_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Carga extends ConsumerStatefulWidget {
  const Carga({super.key});

  @override
  ConsumerState<Carga> createState() => _CargaState();
}

class _CargaState extends ConsumerState<Carga> {
  late ColorScheme theme = Theme.of(context).colorScheme;

  bool isLoading = false;
  late String leyenda;
  late List<ListaPreciosModel>? listaPreciosCargada = [];

  void cargarListaPrecios() async {
    setState(() {
      isLoading = true;
      leyenda = 'Cargando lista de precios...';
    });

    listaPreciosCargada =
        await ref.read(listaPreciosVMProvider.notifier).obtenerListaPrecios();

    setState(() {
      isLoading = false;
    });
  }

  void guardarListaPrecios() async {
    setState(() {
      isLoading = true;
      leyenda = 'Guardando lista de precios...';
    });

    await ref
        .read(holaProvider.notifier)
        .agregarListaPreciosLDB(listaPreciosCargada);

    // if (listaPreciosCargada != null) {
    //   if (listaPreciosCargada!.isNotEmpty) {
    //     late List<ListaPreciosOB> listaPreciosOB = [];
    //
    //     for (ListaPreciosModel item in listaPreciosCargada!) {
    //       ListaPreciosOB list = ListaPreciosOB(
    //         ID_LISTA: item.ID_LISTA,
    //         ID_ARTICULO: item.ID_ARTICULO,
    //         PRECIO: item.PRECIO,
    //         DESCUENTO: item.DESCUENTO,
    //       );
    //       listaPreciosOB.add(list);
    //     }
    //
    //     bool result = ref
    //           .read(listaPreciosLDBVMProvider.notifier)
    //           .agregarListaPreciosLDB(listaPreciosLDB);

    // int i = 1;
    //
    // for (ListaPreciosModel item in listaPreciosCargada!) {
    //   ListaPreciosOB listaPreciosLDB = ListaPreciosOB(
    //     ID_LISTA: item.ID_LISTA,
    //     ID_ARTICULO: item.ID_ARTICULO,
    //     PRECIO: item.PRECIO,
    //     DESCUENTO: item.DESCUENTO,
    //   );
    //
    //   debugPrint(
    //     "Guardando lista precios...${i++}/${listaPreciosCargada?.length}",
    //   );
    //
    //   bool result = ref
    //       .read(listaPreciosLDBVMProvider.notifier)
    //       .agregarListaPreciosLDB(listaPreciosLDB);
    //
    //   if (result == false) {
    //     debugPrint(
    //       "Lista de precios no almacenada, ID_LISTA duplicado: ${listaPreciosLDB.ID_LISTA}, ID_ARTICULO duplicado: ${listaPreciosLDB.ID_ARTICULO}",
    //     );
    //   } else {
    //     debugPrint(
    //       "Guardando lista precios...${i++}/${listaPreciosCargada?.length}",
    //     );
    //   }
    // }
    //   ListaPreciosModel listaPrecios = listaPreciosCargada![105670];
    //
    //   ListaPreciosOB listaPreciosLDB = ListaPreciosOB(
    //     ID_LISTA: listaPrecios.ID_LISTA,
    //     ID_ARTICULO: listaPrecios.ID_ARTICULO,
    //     PRECIO: listaPrecios.PRECIO,
    //     DESCUENTO: listaPrecios.DESCUENTO,
    //   );
    //
    //   bool result = ref
    //       .read(listaPreciosLDBVMProvider.notifier)
    //       .agregarListaPreciosLDB(listaPreciosLDB);
    //
    //   if (result == false) {
    //     debugPrint(
    //       "Lista de precios no almacenada localmente, ID_LISTA duplicado: ${listaPreciosLDB.ID_LISTA}, ID_ARTICULO duplicado: ${listaPreciosLDB.ID_ARTICULO}",
    //     );
    //   } else {
    //     debugPrint(
    //       "Guardando lista precios...${i++}/${listaPreciosCargada?.length}",
    //     );
    //   }
    // } else {
    //   debugPrint("No hay listas de precios para guardar");
    //   }
    // }

    setState(() {
      ref.watch(listaPreciosLDBVMProvider.notifier).getAllListaPreciosLDB();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.onPrimary,
      body: Center(
        child:
            isLoading
                ? Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: theme.primary.withAlpha(95),
                      // color: theme.onPrimary,
                    ),
                    Text(
                      leyenda,
                      //style: TextStyle(color: theme.primary)
                    ),
                  ],
                )
                : Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cargarListaPrecios();
                      },
                      child: Text('Cargar lista precios'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (listaPreciosCargada != null) {
                          guardarListaPrecios();
                        }
                      },
                      child: Text('Guardar lista precios'),
                    ),
                  ],
                ),
      ),
    );
  }
}
