import 'package:crm/data/models/almacen_seleccionado.dart';
import 'package:crm/presentation/viewmodels/pedidos/op_pedido_vm.dart';
import 'package:crm/presentation/widgets/custom_row.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/periodo/fecha_button.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/utils/fechas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:crm/data/models/pedidos/cab_ped_mov_model.dart';
import 'package:crm/presentation/widgets/custom_check_box.dart';
import 'package:crm/presentation/screens/pedidos/pedido/widgets/confirmation_widget.dart';
import 'package:crm/presentation/widgets/custom_stepper.dart';
import 'package:crm/presentation/widgets/menu_almacenes_periodo/widgets/almacenes/almacen_button.dart';

class PedidoScreen extends ConsumerStatefulWidget {
  const PedidoScreen({super.key});

  @override
  ConsumerState<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends ConsumerState<PedidoScreen> {
  late PedidoVM pedidoVM = ref.watch(pedidoVMProvider);

  bool _isEnabled(CabPedMovModel? pedido) =>
      pedido?.ESTATUS == 'FACTURADO' ? false : true;

  late String fecha;

  @override
  void initState() {
    fecha = Fechas().hoyString();
    super.initState();
  }

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

    final bool nuevo = GoRouterState.of(context).extra == false ? false : true;
    final CabPedMovModel? pedido = ref.read(cabPedMovVMProvider).value;

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
              _isEnabled(pedido),
              pedido?.ID_CLIENTE,
            ),
            // Vendedor
            _textField(
              theme,
              'Vendedor',
              nuevo ? true : false,
              pedido?.ID_VENDEDOR,
            ),
            // Sucursal
            _textField(
              theme,
              'Sucursal',
              nuevo ? true : false,
              pedido?.ID_SUCURSAL_CTE,
            ),
            // Atención a
            _textField(
              theme,
              'Atención a',
              nuevo ? true : false,
              pedido?.ATENCION,
            ),
            // Dirección
            _textField(theme, 'Dirección', _isEnabled(pedido), 'Dirección'),
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
              'Fecha de registro',
              IgnorePointer(
                child: FechaButton(
                  fechaExistente:
                      nuevo
                          ? null
                          : Fechas().crearString(pedido!.FECHA_REGISTRO),
                ),
              ),
            ),
            // Fecha orden compra (O.C)
            _customRow(
              'Fecha orden de compra',
              FechaButton(
                fechaExistente:
                    nuevo ? null : Fechas().crearString(pedido!.FECHA_OC),
                setFecha: (String fecha) {
                  pedidoVM.FECHA_OC = fecha;
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
              'Pedido',
              Text(nuevo ? 'NUEVO' : '${pedido?.ID_PEDIDO}'),
            ),
            // Estatus
            _customRow(
              'Estatus',
              Text(
                nuevo ? 'NUEVO' : pedido!.ESTATUS,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // RFC
            _textField(theme, 'RFC', nuevo ? true : false, 'RFC'),
            // Plazo
            _textField(theme, 'Plazo', nuevo ? true : false, 'Plazo'),
            // Descuento
            _textField(theme, 'Descuento', false, pedido?.DESCUENTO),
            // Moneda
            _textField(theme, 'Moneda', nuevo ? true : false, 'Moneda'),
            // Paridad
            _textField(theme, 'Paridad', nuevo ? true : false, pedido?.PARIDAD),
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
              'Fecha inicio consigna',
              FechaButton(
                fechaExistente:
                    nuevo ? null : Fechas().crearString(pedido!.FECHA_INICIOC),
                setFecha: (String fecha) {
                  pedidoVM.FECHA_INICIOC = fecha;
                  debugPrint(
                    'Fecha inicio consigna: ${pedidoVM.FECHA_INICIOC}',
                  );
                },
              ),
            ),
            // Fecha fin consigna
            _customRow(
              'Fecha fin consigna',
              FechaButton(
                fechaExistente:
                    nuevo ? null : Fechas().crearString(pedido!.FECHA_FINC),
                setFecha: (String fecha) {
                  pedidoVM.FECHA_FINC = fecha;
                  debugPrint('Fecha fin consigna: ${pedidoVM.FECHA_FINC}');
                },
              ),
            ),
            // Campo addenda
            _textField(
              theme,
              'Campo addenda',
              nuevo ? true : false,
              pedido?.CampoAddenda,
            ),
            // Observaciones
            _textField(theme, 'Observaciones', true, pedido?.OBSERVACIONES),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomCheckBox(
                  text: 'Autorizar',
                  value: pedido?.Autorizada,
                  onChange: (val) {},
                ),
                CustomCheckBox(
                  text: 'IVA Total Retenido',
                  value: pedido?.RETIENE_IVA,
                  onChange: (val) {},
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
              'Subtotal',
              Text(nuevo ? '\$388.90' : '\$${pedido?.SUBTOTAL}'),
            ),
            // Descuento total
            _customRow(
              '- Descuento total',
              Text(nuevo ? '\$0.00' : '\$${pedido?.DESCUENTO_GLOBAL}'),
            ),
            // IEPS total
            _customRow(
              '+ IEPS Total',
              Text(nuevo ? '\$0.00' : '\$${pedido?.IEPS}'),
            ),
            // Importe con descuento
            _customRow(
              '+ Importe con descuento',
              Text(
                nuevo
                    ? '\$388.90'
                    : '\$${pedido!.IVA_RETENIDO_TOTAL - pedido.DESCUENTO}',
              ),
            ),
            // IVA total
            _customRow(
              '+ IVA Total',
              Text(nuevo ? '\$62.23' : '\$${pedido?.IVA}'),
            ),
            // IVA retenido
            _customRow(
              '- IVA retenido',
              Text(nuevo ? '\$0.00' : '\$${pedido?.IVA_RETENIDO_TOTAL}'),
            ),
            // Gran Total
            _customRow(
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
        actions: [IconButton(onPressed: () {

        }, icon: Icon(Icons.attach_money))],
      ),
      body: CustomStepper(
        steps: steps,
        onLastStepContinue: mostrarConfirmacion,
      ),
    );
  }
}
