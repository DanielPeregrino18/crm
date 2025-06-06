import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/data/models/pedidos/cab_ped_mov_models/cab_pedido_model.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/custom_row.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crm/data/models/pedidos/cab_ped_mov_models/cab_ped_mov_model.dart';
import 'package:crm/presentation/widgets/custom_check_box.dart';
import 'package:crm/presentation/screens/pedido/nuevo_detalle_pedido/widgets/confirmation_widget.dart';
import 'package:crm/presentation/widgets/custom_stepper.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/almacen_button.dart';

class NuevoDetallePedido extends ConsumerStatefulWidget {
  const NuevoDetallePedido({super.key});

  @override
  ConsumerState<NuevoDetallePedido> createState() => _NuevoDetallePedidoState();
}

class _NuevoDetallePedidoState extends ConsumerState<NuevoDetallePedido> {
  late PedidoVM pedidoVM = ref.watch(pedidoVMProvider);

  bool _isEnabled(CabPedidoModel? cabPedido) =>
      cabPedido?.ESTATUS == 'FACTURADO' ? false : true;

  Widget _textField(
    ColorScheme theme,
    String label,
    bool isEnabled,
    dynamic initialValue,
  ) {
    return CustomTextField(
      label: label,
      isEnabled: isEnabled,
      initialValue: initialValue,
    );
  }

  Widget _customRow(String left, Widget right) {
    return CustomRow(left: left, right: right);
  }

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

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    final CabPedMovModel? cabPedMov = ref.read(cabPedMovVMProvider).value;
    final CabPedidoModel? cabPedido = cabPedMov?.cabPedido;
    final bool nuevo = cabPedMov == null ? true : false;

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
              'Almacén',
              nuevo
                  ? AlmacenButton(
                    setAlmacen: (int id, String nombre) {
                      pedidoVM.almacenSeleccionado = AlmacenSeleccionado(
                        id: id,
                        nombre: nombre,
                      );
                      debugPrint(
                        'Id almacén: ${pedidoVM.almacenSeleccionado.id}',
                      );
                    },
                  )
                  : IgnorePointer(child: AlmacenButton()),
            ),
            // Cliente
            _textField(
              theme,
              'Cliente',
              _isEnabled(cabPedido),
              cabPedido?.Nombre,
            ),
            // Vendedor
            _textField(
              theme,
              'Vendedor',
              nuevo ? true : false,
              cabPedido?.ID_VENDEDOR,
            ),
            // Sucursal
            _textField(
              theme,
              'Sucursal',
              nuevo ? true : false,
              cabPedido?.ID_SUCURSAL_CTE,
            ),
            // Atención a
            _textField(
              theme,
              'Atención a',
              nuevo ? true : false,
              cabPedido?.ATENCION,
            ),
            // Dirección
            _textField(theme, 'Dirección', _isEnabled(cabPedido), 'Dirección'),
            // Lista de precios
            _textField(
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
              'F. Registro',
              IgnorePointer(
                child: FechaButton(
                  fechaExistente: nuevo ? null : cabPedido!.FECHA_REGISTRO!,
                ),
              ),
            ),
            // Fecha orden compra (O.C)
            _customRow(
              'F. Orden compra',
              FechaButton(
                fechaExistente: nuevo ? null : cabPedido!.FECHA_OC!,
                setFecha: (DateTime fechaOC) {
                  pedidoVM.FECHA_OC = fecha.crearString(fechaOC);
                  debugPrint('Fecha O.C: ${pedidoVM.FECHA_OC}');
                },
              ),
            ),
            // No. de Serie
            _textField(
              theme,
              'No. de Serie',
              nuevo ? true : false,
              'No. de Serie',
            ),
            // Orden de compra
            _textField(
              theme,
              'Orden compra',
              _isEnabled(cabPedido),
              cabPedido?.OrdenCompra,
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
              'Pedido',
              Text(nuevo ? 'NUEVO' : '${cabPedido?.ID_PEDIDO!}'),
            ),
            // Estatus
            _customRow(
              'Estatus',
              Text(
                nuevo ? 'NUEVO' : cabPedido!.ESTATUS!,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // RFC
            _textField(
              theme,
              'RFC',
              nuevo ? true : false,
              nuevo ? '' : cabPedMov.rfc,
            ),
            // Plazo
            _textField(theme, 'Plazo', nuevo ? true : false, 'Plazo'),
            // Descuento
            _textField(theme, 'Descuento', false, cabPedido?.DESCUENTO),
            // Moneda
            _textField(theme, 'Moneda', nuevo ? true : false, 'Moneda'),
            // Paridad
            _textField(
              theme,
              'Paridad',
              nuevo ? true : false,
              cabPedido?.PARIDAD,
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
              'F. Inicio consigna',
              FechaButton(
                fechaExistente: nuevo ? null : cabPedido!.FECHA_INICIOC!,
                setFecha: (DateTime fechaIC) {
                  pedidoVM.FECHA_INICIOC = fecha.crearString(fechaIC);
                  debugPrint(
                    'Fecha inicio consigna: ${pedidoVM.FECHA_INICIOC}',
                  );
                },
              ),
            ),
            // Fecha fin consigna
            _customRow(
              'F. Fin consigna',
              FechaButton(
                fechaExistente: nuevo ? null : cabPedido!.FECHA_FINC!,
                setFecha: (DateTime fechaFC) {
                  pedidoVM.FECHA_FINC = fecha.crearString(fechaFC);
                  debugPrint('F. Fin consigna: ${pedidoVM.FECHA_FINC}');
                },
              ),
            ),
            // Campo addenda
            _textField(
              theme,
              'Campo addenda',
              nuevo ? true : false,
              cabPedido?.CampoAddenda,
            ),
            // Observaciones
            _textField(theme, 'Observaciones', true, cabPedido?.OBSERVACIONES),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // CustomCheckBox(
                //   text: 'Autorizar',
                //   value: pedido?.Autorizada,
                //   onChange: (val) {},
                // ),
                // CustomCheckBox(
                //   text: 'IVA Total Retenido',
                //   value: pedido?.RETIENE_IVA,
                //   onChange: (val) {},
                // ),
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
              'Subtotal',
              Text(nuevo ? '\$388.90' : '\$${cabPedido?.SUBTOTAL}'),
            ),
            // Descuento total
            _customRow(
              '- Descuento total',
              Text(nuevo ? '\$0.00' : '\$${cabPedido?.DESCUENTO_GLOBAL}'),
            ),
            // IEPS total
            _customRow(
              '+ IEPS Total',
              Text(nuevo ? '\$0.00' : '\$${cabPedido?.IEPS}'),
            ),
            // Importe con descuento
            _customRow(
              '+ Importe con descuento',
              Text(
                nuevo
                    ? '\$388.90'
                    : '\$${cabPedido!.IVA_RETENIDO_TOTAL! - cabPedido.DESCUENTO!}',
              ),
            ),
            // IVA total
            _customRow(
              '+ IVA Total',
              Text(nuevo ? '\$62.23' : '\$${cabPedido?.IVA}'),
            ),
            // IVA retenido
            _customRow(
              '- IVA retenido',
              Text(nuevo ? '\$0.00' : '\$${cabPedido?.IVA_RETENIDO_TOTAL}'),
            ),
            // Gran Total
            _customRow(
              '= Gran total',
              Text(nuevo ? '\$451.13' : '\$${cabPedido?.SUBTOTAL}'),
            ),
          ],
        ),
      ),
    ];

    Function? mostrarConfirmacion() {
      if (cabPedido == null) {
        modalButtonSheetFullScreen(ConfirmationWidget());
      }
      return null;
    }

    final GlobalKey<CustomStepperState> customStepperKey =
        GlobalKey<CustomStepperState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text(
          nuevo ? 'Nuevo Pedido' : 'Detalles Pedido',
          style: TextStyle(color: theme.onPrimary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size.zero),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStatePropertyAll(
                  theme.onPrimary.withAlpha(60),
                ),
              ),
              onPressed: () {
                customStepperKey.currentState?.goToLastStep();
              },
              child: Text(
                'Total: \$${cabPedido?.SUBTOTAL ?? 0}',
                style: TextStyle(color: theme.onPrimary),
              ),
            ),
          ),
        ],
      ),
      body: CustomStepper(
        key: customStepperKey,
        steps: steps,
        onLastStepContinue: mostrarConfirmacion,
      ),
    );
  }
}
