import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crm/presentation/widgets/custom_action_buttons.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';

class ModalBusquedaArticulos extends StatefulWidget {
  const ModalBusquedaArticulos({super.key, required this.theme});

  final ColorScheme theme;

  @override
  State<ModalBusquedaArticulos> createState() => _ModalBusquedaArticulosState();
}

class _ModalBusquedaArticulosState extends State<ModalBusquedaArticulos> {
  late bool _mostrarInactivos;

  late bool _precioConIVA;

  late ColorScheme _theme;

  @override
  void initState() {
    super.initState();
    _mostrarInactivos = false;
    _precioConIVA = false;
    _theme = widget.theme;
  }

  final TextEditingController codigoIntController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController familiaController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController tipoArticuloController = TextEditingController();
  final TextEditingController noParteController = TextEditingController();
  final TextEditingController codigoBarrasController = TextEditingController();
  final TextEditingController presentacionController = TextEditingController();
  final TextEditingController codigoAnteriorController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<FloatingActionButton> buttons = [
      FloatingActionButton(
        elevation: 4,
        tooltip: 'Cancelar',
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close, color: _theme.primary),
      ),
      FloatingActionButton(
        elevation: 4,
        tooltip: 'Buscar Artículo',
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.search, color: _theme.primary),
      ),
    ];

    return Scaffold(
      backgroundColor: _theme.onPrimary,
      appBar: AppBar(
        backgroundColor: _theme.onPrimary,
        automaticallyImplyLeading: false,
        title: Text(
          'Búsqueda de Artículos',
          style: TextStyle(color: _theme.primary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          spacing: 10,
          children: [
            // Filtros
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 0,
                  children: [
                    Checkbox(
                      checkColor: _theme.primary,
                      fillColor: WidgetStatePropertyAll(Colors.transparent),
                      value: _mostrarInactivos,
                      onChanged: (bool? value) {
                        setState(() {
                          _mostrarInactivos = value!;
                        });
                      },
                    ),
                    Text('Mostrar inactivos'),
                  ],
                ),
                Row(
                  spacing: 0,
                  children: [
                    Checkbox(
                      checkColor: _theme.primary,
                      fillColor: WidgetStatePropertyAll(Colors.transparent),
                      value: _precioConIVA,
                      onChanged: (bool? value) {
                        setState(() {
                          _precioConIVA = value!;
                        });
                      },
                    ),
                    Text('Precio C/IVA'),
                  ],
                ),
              ],
            ),
            // Campos
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                children: [
                  // Código - Nombre
                  // CustomTextField(
                  //   theme: _theme,
                  //   textInputType: TextInputType.number,
                  //   textEditingController: codigoIntController,
                  //   textInputFormatters: [
                  //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //   ],
                  //   content: 'Código int.',
                  // ),
                  CustomTextField(
                    label: 'Código int.',
                    textInputType: TextInputType.number,
                    textInputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    isEnabled: true,
                    controller: codigoIntController,
                  ),
                  // CustomTextField(
                  //   theme: _theme,
                  //   textInputType: TextInputType.text,
                  //   textEditingController: nombreController,
                  //   content: 'Nombre',
                  // ),
                  Divider(color: _theme.primary.withAlpha(60)),
                  // Marca - Familia
                  Row(
                    spacing: 10,
                    children: [
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.text,
                      //     textEditingController: marcaController,
                      //     content: 'Marca',
                      //   ),
                      // ),
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.text,
                      //     textEditingController: familiaController,
                      //     content: 'Familia',
                      //   ),
                      // ),
                    ],
                  ),
                  // Categoría - Tipo artículo
                  Row(
                    spacing: 10,
                    children: [
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.text,
                      //     textEditingController: categoriaController,
                      //     content: 'Categoría',
                      //   ),
                      // ),
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.text,
                      //     textEditingController: tipoArticuloController,
                      //     content: 'Tipo artículo',
                      //   ),
                      // ),
                    ],
                  ),
                  Divider(color: _theme.primary.withAlpha(60)),
                  // No. parte - Código barras
                  Row(
                    spacing: 10,
                    children: [
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.number,
                      //     textEditingController: noParteController,
                      //     textInputFormatters: [
                      //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      //     ],
                      //     content: 'No. Parte',
                      //   ),
                      // ),
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.number,
                      //     textEditingController: codigoBarrasController,
                      //     textInputFormatters: [
                      //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      //     ],
                      //     content: 'Código Barras',
                      //   ),
                      // ),
                    ],
                  ),
                  // Presentación - Código anterior
                  Row(
                    spacing: 10,
                    children: [
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.text,
                      //     textEditingController: presentacionController,
                      //     content: 'Presentación',
                      //   ),
                      // ),
                      // Expanded(
                      //   child: CustomTextField(
                      //     theme: _theme,
                      //     textInputType: TextInputType.number,
                      //     textEditingController: codigoAnteriorController,
                      //     textInputFormatters: [
                      //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      //     ],
                      //     content: 'Código anterior',
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomActionButtons(theme: _theme, buttons: buttons),
      ),
    );
  }
}
