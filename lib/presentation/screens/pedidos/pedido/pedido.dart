import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:crm/data/models/pedido_model.dart';
import 'package:crm/presentation/widgets/custom_check_box.dart';
import 'package:crm/presentation/screens/pedidos/pedido/widgets/confirmation_widget.dart';
import 'package:crm/presentation/viewmodels/pedidos/pedidos_vm.dart';
import 'package:crm/presentation/widgets/custom_stepper.dart';

class PedidoScreen extends ConsumerStatefulWidget {
  const PedidoScreen({super.key});

  @override
  ConsumerState<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends ConsumerState<PedidoScreen> {
  late PedidosVM pedidosVM = ref.watch(pedidosVMProvider);

  late String almacen =
      '${pedidosVM.almacenSeleccionado.id}. ${pedidosVM.almacenSeleccionado.nombre}';

  TextFormField _customTextField(
    ColorScheme theme,
    String label,
    bool isEnabled,
    dynamic initialValue,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: theme.primary.withAlpha(15),
        label: Text(label),
        floatingLabelStyle: TextStyle(fontSize: 20),
      ),
      enabled: isEnabled,
      initialValue: initialValue == null ? null : '$initialValue',
    );
  }

  Widget _customRow(ColorScheme theme, String left, Widget right) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: TextStyle(fontWeight: FontWeight.w600)),
          right,
        ],
      ),
    );
  }

  final String fechaInicial = '29/05/2023';

  void modalButtonSheetFullScreen(Widget menu) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return menu;
      },
    );
  }

  bool _isEnabled(Pedido? pedido) =>
      pedido?.ESTATUS == 'FACTURADO' ? false : true;

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final bool nuevo = GoRouterState.of(context).extra == false ? false : true;
    final Pedido? pedido = ref.read(getPedidoProvider).value;

    int currentStep = 0;

    List<Step> steps = [
      // Datos del Pedido 1/4
      Step(
        isActive: currentStep == 0,
        title: Text('Datos del Pedido'),
        subtitle: Text('1/4'),
        content: Column(
          spacing: 15,
          children: [
            // Almacén
            _customRow(
              theme,
              'Almacén',
              TextButton(
                child: Text(
                  nuevo ? almacen : '${pedido?.ID_ALMACEN}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (pedido == null) {
                    // mostrarMenu(MenuAlmacenes());
                  }
                },
              ),
            ),
            // Cliente
            _customTextField(
              theme,
              'Cliente',
              _isEnabled(pedido),
              pedido?.ID_CLIENTE,
            ),
            // Vendedor
            _customTextField(
              theme,
              'Vendedor',
              nuevo ? true : false,
              pedido?.ID_VENDEDOR,
            ),
            // Sucursal
            _customTextField(
              theme,
              'Sucursal',
              nuevo ? true : false,
              pedido?.ID_SUCURSAL_CTE,
            ),
            // Atención a
            _customTextField(
              theme,
              'Atención a',
              nuevo ? true : false,
              pedido?.ATENCION,
            ),
            // Dirección
            _customTextField(
              theme,
              'Dirección',
              _isEnabled(pedido),
              'Dirección',
            ),
            // Lista de precios
            _customTextField(
              theme,
              'Lista de precios',
              nuevo ? true : false,
              'Lista precios',
            ),
          ],
        ),
      ),
      // Datos del Pedido 2/4
      Step(
        isActive: currentStep == 1,
        title: Text('Datos del Pedido'),
        subtitle: Text('2/4'),
        content: Column(
          spacing: 15,
          children: [
            // Fecha de registro
            _customRow(
              theme,
              'Fecha de registro',
              TextButton(
                child: Text(
                  nuevo ? fechaInicial : pedido!.FECHA_REGISTRO,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (pedido == null) {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime.now(),
                    );
                  }
                },
              ),
            ),
            // Fecha orden compra (O.C)
            _customRow(
              theme,
              'Fecha orden de compra',
              TextButton(
                child: Text(
                  nuevo ? fechaInicial : fechaInicial,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (pedido == null) {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime.now(),
                    );
                  }
                },
              ),
            ),
            // No. de Serie
            _customTextField(
              theme,
              'No. de Serie',
              nuevo ? true : false,
              'No. de Serie',
            ),
            // Orden de compra
            _customTextField(
              theme,
              'Orden de compra',
              _isEnabled(pedido),
              pedido?.OrdenCompra,
            ),
          ],
        ),
      ),
      // Datos del Pedido 3/4
      Step(
        isActive: currentStep == 2,
        title: Text('Datos del Pedido'),
        subtitle: Text('3/4'),
        content: Column(
          spacing: 15,
          children: [
            // Número de pedido
            _customRow(
              theme,
              'Pedido',
              Text(nuevo ? '15550' : '${pedido?.ID_PEDIDO}'),
            ),
            // Estatus
            _customRow(
              theme,
              'Estatus',
              Text(
                nuevo ? 'NUEVO' : pedido!.ESTATUS,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // RFC
            _customTextField(theme, 'RFC', nuevo ? true : false, 'RFC'),
            // Plazo
            _customTextField(theme, 'Plazo', nuevo ? true : false, 'Plazo'),
            // Descuento
            _customTextField(theme, 'Descuento', false, pedido?.DESCUENTO),
            // Moneda
            _customTextField(theme, 'Moneda', nuevo ? true : false, 'Moneda'),
            // Paridad
            _customTextField(
              theme,
              'Paridad',
              nuevo ? true : false,
              pedido?.PARIDAD,
            ),
          ],
        ),
      ),
      // Datos del Pedido 4/4
      Step(
        isActive: currentStep == 3,
        title: Text('Datos del Pedido'),
        subtitle: Text('4/4'),
        content: Column(
          spacing: 15,
          children: [
            // Fecha inicio consigna
            _customRow(
              theme,
              'Fecha inicio consigna',
              TextButton(
                child: Text(
                  nuevo ? fechaInicial : pedido!.FECHA_INICIOC,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (pedido == null) {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime.now(),
                    );
                  }
                },
              ),
            ),
            // Fecha fin consigna
            _customRow(
              theme,
              'Fecha fin consigna',
              TextButton(
                child: Text(
                  nuevo ? fechaInicial : pedido!.FECHA_FINC,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  if (pedido == null) {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2015),
                      lastDate: DateTime.now(),
                    );
                  }
                },
              ),
            ),
            // Campo addenda
            _customTextField(
              theme,
              'Campo addenda',
              nuevo ? true : false,
              pedido?.CampoAddenda,
            ),
            // Observaciones
            _customTextField(
              theme,
              'Observaciones',
              true,
              pedido?.OBSERVACIONES,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomCheckBox(
                  text: 'Autorizar',
                  value: pedido?.Autorizada,
                  onChange: (val){},
                ),
                CustomCheckBox(
                  text: 'IVA Total Retenido',
                  value: pedido?.RETIENE_IVA,
                  onChange: (val){},
                ),
              ],
            ),
          ],
        ),
      ),
      // Capturar Artículos
      Step(
        isActive: currentStep == 4,
        title: Text('Artículos'),
        subtitle: Text('Capturar Artículos'),
        content: Column(
          spacing: 10,
          children: [
            // ArticulosSearchBar(theme: theme),
            // ArticulosExpansionPanelList(),
          ],
        ),
      ),
      // Totales
      Step(
        isActive: currentStep == 5,
        title: Text('Totales'),
        content: Column(
          spacing: 10,
          children: [
            // Subtotal
            _customRow(
              theme,
              'Subtotal',
              Text(nuevo ? '\$388.90' : '\$${pedido?.SUBTOTAL}'),
            ),
            // Descuento total
            _customRow(
              theme,
              '- Descuento total',
              Text(nuevo ? '\$0.00' : '\$${pedido?.DESCUENTO_GLOBAL}'),
            ),
            // IEPS total
            _customRow(
              theme,
              '+ IEPS Total',
              Text(nuevo ? '\$0.00' : '\$${pedido?.IEPS}'),
            ),
            // Importe con descuento
            _customRow(
              theme,
              '+ Importe con descuento',
              Text(
                nuevo
                    ? '\$388.90'
                    : '\$${pedido!.IVA_RETENIDO_TOTAL - pedido.DESCUENTO}',
              ),
            ),
            // IVA total
            _customRow(
              theme,
              '+ IVA Total',
              Text(nuevo ? '\$62.23' : '\$${pedido?.IVA}'),
            ),
            // IVA retenido
            _customRow(
              theme,
              '- IVA retenido',
              Text(nuevo ? '\$0.00' : '\$${pedido?.IVA_RETENIDO_TOTAL}'),
            ),
            // Gran Total
            _customRow(
              theme,
              '= Gran total',
              Text(nuevo ? '\$451.13' : '\$${pedido?.SUBTOTAL}'),
            ),
          ],
        ),
      ),
    ];

    Function? mostrarConfirmacion() {
      if (pedido == null) {
        modalButtonSheetFullScreen(ConfirmationWidget());
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text(
          nuevo ? 'Nuevo Pedido' : 'Detalles Pedido',
          style: TextStyle(color: theme.onPrimary),
        ),
      ),
      body: CustomStepper(
        steps: steps,
        onLastStepContinue: mostrarConfirmacion(),
      ),
    );
  }
}
