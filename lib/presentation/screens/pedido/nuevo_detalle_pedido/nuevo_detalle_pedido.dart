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
import 'package:go_router/go_router.dart';

class NuevoDetallePedido extends ConsumerStatefulWidget {
  const NuevoDetallePedido({super.key});

  @override
  ConsumerState<NuevoDetallePedido> createState() => _NuevoDetallePedidoState();
}

class _NuevoDetallePedidoState extends ConsumerState<NuevoDetallePedido> {
  late bool nuevo = GoRouterState.of(context).extra == true ? true : false;

  bool _isEnabled(CabPedidoModel? cabPedido) =>
      cabPedido?.ESTATUS == 'FACTURADO' ? false : true;

  Widget _textField(String label, dynamic initialValue, [bool? isEnabled]) {
    return CustomTextField(
      label: label,
      isEnabled: nuevo ? true : isEnabled ?? false,
      initialValue: nuevo ? null : initialValue,
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

    final PedidoVM pedidoVM = ref.watch(pedidoVMProvider);
    final CabPedMovModel? cabPedMov = ref.read(cabPedMovVMProvider).value;
    final CabPedidoModel? cabPedido = cabPedMov?.cabPedido;

    int currentStep = 0;

    final GlobalKey<CustomStepperState> customStepperKey =
        GlobalKey<CustomStepperState>();

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
                  : IgnorePointer(
                    child: AlmacenButton(
                      initialValueIdAlmacen: cabPedido?.ID_ALMACEN,
                    ),
                  ),
            ),
            // Cliente
            _textField('Cliente', cabPedido?.Nombre, _isEnabled(cabPedido)),
            // Vendedor
            _textField('Vendedor', cabPedido?.ID_VENDEDOR),
            // Sucursal
            _textField('Sucursal', cabPedido?.ID_SUCURSAL_CTE),
            // Atención a
            _textField('Atención a', cabPedido?.ATENCION),
            // Dirección
            _textField('Dirección', 'Dirección', _isEnabled(cabPedido)),
            // Lista de precios
            _textField('Lista de precios', 'Lista precios'),
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
            _textField('No. de Serie', 'No. de Serie'),
            // Orden de compra
            _textField(
              'Orden compra',
              cabPedido?.OrdenCompra,
              _isEnabled(cabPedido),
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
            _textField('RFC', nuevo ? '' : cabPedMov?.rfc),
            // Plazo
            _textField('Plazo', 'Plazo'),
            // Descuento
            _textField('Descuento', cabPedido?.DESCUENTO, false),
            // Moneda
            _textField('Moneda', 'Moneda'),
            // Paridad
            _textField('Paridad', cabPedido?.PARIDAD),
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
            _textField('Campo addenda', cabPedido?.CampoAddenda),
            // Observaciones
            _textField('Observaciones', cabPedido?.OBSERVACIONES, true),
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
        onLastStepContinue: () {
          if (nuevo) {
            modalButtonSheetFullScreen(ConfirmationWidget());
          }
        },
      ),
    );
  }
}
