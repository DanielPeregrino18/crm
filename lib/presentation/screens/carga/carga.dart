import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/data/models/colecciones/lista_precios_model.dart';
import 'package:crm/presentation/viewmodels/colecciones/lista_precios_vm.dart';
import 'package:go_router/go_router.dart';

class Carga extends ConsumerStatefulWidget {
  const Carga({super.key});

  @override
  ConsumerState<Carga> createState() => _CargaState();
}

class _CargaState extends ConsumerState<Carga> {
  bool isLoading = false;
  String leyenda = 'Cargando...';
  List<ListaPreciosModel>? listaPreciosCargada = [];

  void cargarGuardarListaPrecios() async {
    bool result = false;

    // Consulta datos

    setState(() {
      isLoading = true;
      leyenda = 'Cargando lista de precios...';
    });

    listaPreciosCargada =
        await ref.read(listaPreciosVMProvider.notifier).obtenerListaPrecios();

    // Guardado en local

    setState(() {
      leyenda = 'Guardando lista de precios...';
    });

    result = ref
        .read(listaPreciosLDBVMProvider.notifier)
        .agregarColeccionListaPreciosLDB(listaPreciosCargada);

    await Future.delayed(const Duration(seconds: 2), () {});

    setState(() {
      leyenda =
          result
              ? 'Lista de precios guardada correctamente'
              : 'Error al guardar la lista de precios';
    });

    await Future.delayed(const Duration(seconds: 2), () {});

    setState(() {
      ref.watch(listaPreciosLDBVMProvider.notifier).getAllListaPreciosLDB();
      isLoading = false;
    });

    // Redirección siguiente pantalla
    if (mounted && result) {
      context.go('/');
    }
  }

  @override
  void initState() {
    // cargarGuardarListaPrecios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

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
                    TextButton.icon(
                      onPressed: () {
                        cargarGuardarListaPrecios();
                      },
                      label: Text('Lista de precios'),
                      icon: Icon(Icons.list),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.go('/');
                      },
                      label: Text('Inicio'),
                      icon: Icon(Icons.home),
                    ),
                  ],
                ),
      ),
    );
  }
}
