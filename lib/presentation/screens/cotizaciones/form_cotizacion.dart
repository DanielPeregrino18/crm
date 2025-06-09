import 'package:crm/presentation/viewmodels/cotizaciones/form_cotizacion_vm.dart';
import 'package:crm/presentation/viewmodels/vendedor_vm.dart';
import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:crm/presentation/widgets/custom_search_bar.dart';
import 'package:crm/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/cliente_vm.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/menu_almacenes_periodo/widgets/almacenes/menu_almacenes.dart';

class FormCotizacion extends ConsumerStatefulWidget {
  const FormCotizacion({Key? key}) : super(key: key);

  @override
  ConsumerState<FormCotizacion> createState() => _FormCotizacionState();
}

class _FormCotizacionState extends ConsumerState<FormCotizacion> {
  int _currentStep = 0;

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

  void mostrarMenu(Widget menu, bool isScrollController) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: isScrollController,
      context: context,
      builder: (BuildContext context) {
        return menu;
      },
    );
  }

  List<Map<String, dynamic>> listaPrecios = [
    {"nombre": "PR. AL PUBLICO", "id": 1},
    {"nombre": "Prueba2", "id": 2},
    {"nombre": "Prueba3", "id": 3},
    {"nombre": "Prueba4", "id": 4},
    {"nombre": "Prueba5", "id": 5},
  ];
  List<Map<String, dynamic>> listaMonedas = [
    {"nombre": "MXN", "id": 1},
    {"nombre": "USD", "id": 2},
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final formCotizacionVM = ref.watch(formCotizacionVMProvider);
    String estatus = formCotizacionVM.estatusLabel;
    bool isEnabled = estatus == "NUEVO" || estatus == "COTIZADO";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text(
          estatus == "NUEVO" ? 'Nueva Cotización' : 'Detalles Cotización',
          style: TextStyle(color: theme.onPrimary),
        ),
        actions: [
          TextButton(onPressed: () {
            setState(() {
              _currentStep = 6;
            });
          }, child: Text("Total: \$4852", style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Stepper(
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
                _currentStep == 0
                    ? ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('Siguiente'),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Atrás'),
                        ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            _currentStep == 6 ? 'Finalizar' : 'Siguiente',
                          ),
                        ),
                      ],
                    ),
          );
        },
        steps: [
          Step(
            isActive: true,
            title: Text('Datos de la cotización'),
            subtitle: Text('1/4'),
            content: Column(
              spacing: 15,
              children: [
                _customRow(
                  theme,
                  'Almacén',
                  TextButton(
                    child: Text(
                      ref.watch(formCotizacionVMProvider).almacenLabel,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      if (isEnabled) {
                        mostrarMenu(
                          MenuAlmacenes(setAlmacen: (int id, String nombre) {
                            formCotizacionVM.setAlmacenLabel(nombre);
                            formCotizacionVM.idAlmacen = id;
                          }),
                          false,
                        );
                      }
                    },
                  ),
                ),
                CustomSearchBar(
                    controller: formCotizacionVM.vendedorController,
                    focusNode: formCotizacionVM.focusVendedor,
                    itemBuilder: (context, value) {
                      return ListTile(title: Text("${value.id}.-${value.nombre}"),);
                    },
                    sugerencias: (search) {
                      return ref.read(vendedorVMProvider).getVendedoresFiltro(search);
                    },
                    onSelect: (value) {
                      formCotizacionVM.setVendedor(value);
                    },
                    label: "Vendedor"
                ),
                CustomSearchBar(
                    controller: formCotizacionVM.clienteController,
                    focusNode: formCotizacionVM.focusCliente,
                    itemBuilder: (context, value) {
                      return ListTile(
                        title: Text("${value.idCliente}.- ${value.nombre}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(value.razonSocial),
                            Text(value.rfc)
                          ],
                        ),
                      );
                    },
                    sugerencias: (search) {
                      return ref
                          .read(clienteVMProvider)
                          .getClientesFiltro(search);
                    },
                    onSelect: (value) {
                      formCotizacionVM.setCliente(value);
                    },
                    label: "Cliente"
                ),
                CustomTextField(
                  label: "Sucursal",
                  controller: formCotizacionVM.sucursalController,
                  isEnabled: false
                ),
                CustomTextField(
                    label: "Dirección",
                    controller: formCotizacionVM.direccionController,
                    isEnabled: false
                ),
                _customRow(
                  theme,
                  'Lista de Precios',
                  estatus == "NUEVO" ? DropdownButton(
                    value: formCotizacionVM.idListaPrecios,
                    items:
                        listaPrecios
                            .map(
                              (e) => DropdownMenuItem(
                                value: e['id'],
                                child: Text('${e['nombre']}'),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      formCotizacionVM.setIdListaPrecios(value as int);
                    },
                  ) : Text('${listaPrecios.firstWhere((element) => element['id'] == formCotizacionVM.idListaPrecios,)['nombre']}'),
                ),
                _customRow(
                  theme,
                  'Fecha vigencia',
                  TextButton(
                    child: Text(
                      formCotizacionVM.getfechaVigencia(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () async {
                      formCotizacionVM.setFechaVigencia(await customDatePicker(context, initialDate: formCotizacionVM.fechaVigencia));
                    },
                  ),
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep >= 1,
            title: Text('Datos de la cotización'),
            subtitle: Text('2/4'),
            content: Column(
              spacing: 15,
              children: [
                _customRow(
                  theme,
                  'Fecha de registro',
                  TextButton(
                    child: Text(
                      formCotizacionVM.getFechaRegistro(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                _customRow(
                  theme,
                  'Fecha orden de compra',
                  TextButton(
                    child: Text(
                      formCotizacionVM.getFechaOC(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () async {
                      if (isEnabled) {
                       formCotizacionVM.setFechaOrdenCompra(await customDatePicker(context, initialDate: formCotizacionVM.fechaOrdenCompra));
                      }
                    },
                  ),
                ),
                CustomTextField(
                    label: "No. de Serie",
                    controller: formCotizacionVM.noSerieController,
                    isEnabled: isEnabled
                ),
                CustomTextField(
                    label: "Orden de compra",
                    controller: formCotizacionVM.ordenCompraController,
                    isEnabled: isEnabled
                ),
                CustomTextField(
                    label: "Procesado",
                    controller: formCotizacionVM.procesadoController,
                    isEnabled: false
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep >= 2,
            title: Text('Datos de la cotización'),
            subtitle: Text('3/4'),
            content: Column(
              spacing: 15,
              children: [
                _customRow(
                  theme,
                  'Cotización',
                  Text(formCotizacionVM.cotizacionLabel),
                ),
                _customRow(
                  theme,
                  'Estatus',
                  Text(
                    formCotizacionVM.estatusLabel,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                CustomTextField(
                    label: "RFC",
                    controller: formCotizacionVM.rfcController,
                    isEnabled: false
                ),
                CustomTextField(
                    label: "Plazo",
                    controller: formCotizacionVM.plazoController,
                    isEnabled: false
                ),
                CustomTextField(
                    label: "Descuento",
                    controller: formCotizacionVM.descuentoController,
                    isEnabled: isEnabled
                ),
                _customRow(
                  theme,
                  'Moneda',
                  estatus == "NUEVO" ? DropdownButton(
                    value: formCotizacionVM.idMoneda,
                    items:
                    listaMonedas
                        .map(
                          (e) => DropdownMenuItem(
                        value: e['id'],
                        child: Text('${e['nombre']}'),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                        formCotizacionVM.setMoneda(value as int);
                    },
                  ) : Text('${listaMonedas.firstWhere((element) => element['id'] == formCotizacionVM.idMoneda,)['nombre']}'),
                ),
                CustomTextField(
                    label: "Paridad",
                    controller: formCotizacionVM.paridadController,
                    isEnabled: false
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep >= 3,
            title: Text('Datos de la cotización'),
            subtitle: Text('4/4'),
            content: Column(
              spacing: 15,
              children: [
                _customRow(
                  theme,
                  'Fecha inicio consigna',
                  TextButton(
                    child: Text(
                      formCotizacionVM.getFechaInicioConsigna(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () async {
                      if (isEnabled) {
                        formCotizacionVM.setFechaInicioConsigna(await customDatePicker(context, initialDate: formCotizacionVM.fechaInicioConsigna));
                      }
                    },
                  ),
                ),
                _customRow(
                  theme,
                  'Fecha fin consigna',
                  TextButton(
                    child: Text(
                      formCotizacionVM.getfechaFinConsigna(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () async {
                      if (isEnabled) {
                        formCotizacionVM.setFechaFinConsigna(await customDatePicker(context, initialDate: formCotizacionVM.fechaFinConsigna));
                      }
                    },
                  ),
                ),
                CustomTextField(
                    label: "Campo addenda",
                    controller: formCotizacionVM.campoAddendaController,
                    isEnabled: isEnabled
                ),
                CustomTextField(
                    label: "Observaciones",
                    controller: formCotizacionVM.observacionesController,
                    isEnabled: isEnabled
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCheckBox(
                      text: 'Autorizar',
                      value: formCotizacionVM.autorizar,
                      onChange: (val) {
                        if (isEnabled) {
                            formCotizacionVM.setAutorizar(val);
                        }
                      },
                    ),
                    CustomCheckBox(
                      text: 'IVA Total Retenido',
                      value: formCotizacionVM.ivaTotalRetenido,
                      onChange: (val) {
                        if (isEnabled) {
                          formCotizacionVM.setIvaTRetenido(val);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep >= 4,
            title: Text('Domicilio'),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                spacing: 15,
                children: [
                  CustomTextField(
                    label: "Domicilio",
                    controller: formCotizacionVM.domicilioController,
                  ),
                  CustomTextField(
                    label: "Colonia",
                    controller: formCotizacionVM.coloniaController,
                  ),
                  CustomTextField(
                      label: "Estado",
                      controller: formCotizacionVM.estadoController,
                      isEnabled: true
                  ),
                  CustomTextField(
                      label: "Ciudad",
                      controller: formCotizacionVM.ciudadController,
                      isEnabled: true
                  ),
                  CustomTextField(
                      label: "Entre calles",
                      controller: formCotizacionVM.entreCallesController,
                      isEnabled: true
                  ),
                  CustomTextField(
                      label: "Atención a",
                      controller: formCotizacionVM.atencionAContoller,
                      isEnabled: isEnabled
                  ),
                  _customRow(
                    theme,
                    'Fecha de Entrega',
                    TextButton(
                      child: Text(
                        formCotizacionVM.getfechaEntrega(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () async {
                        formCotizacionVM.setFechaEntrega(await customDatePicker(context));
                      },
                    ),
                  ),
                  _customRow(
                    theme,
                    'Hora de Entrega',
                    TextButton(
                      child: Text(
                        formCotizacionVM.horaEntrega.format(context),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () async {
                        formCotizacionVM.setHoraEntrega(
                            await customHourPicker(
                              context,
                              formCotizacionVM.horaEntrega.hour,
                              formCotizacionVM.horaEntrega.minute,
                              "Hora de entrega",
                            )
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            isActive: _currentStep >= 5,
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
          Step(
            isActive: _currentStep == 6,
            title: Text('Totales'),
            content: Column(
              spacing: 10,
              children: [
                _customRow(
                  theme,
                  'Subtotal',
                  Text('\$${formCotizacionVM.subtotal.toStringAsFixed(2)}'),
                ),
                _customRow(
                  theme,
                  '- Descuento total',
                  Text('\$${formCotizacionVM.descTotal.toStringAsFixed(2)}'),
                ),
                _customRow(
                  theme,
                  '+ IEPS Total',
                  Text('\$${formCotizacionVM.iepsTotal.toStringAsFixed(2)}'),
                ),
                _customRow(
                  theme,
                  '+ Importe con descuento',
                  Text(
                    '\$${formCotizacionVM.importeDescuento.toStringAsFixed(2)}',
                  ),
                ),
                _customRow(
                  theme,
                  '+ IVA Total',
                  Text('\$${formCotizacionVM.ivaTotal.toStringAsFixed(2)}'),
                ),
                _customRow(
                  theme,
                  '- IVA retenido',
                  Text('\$${formCotizacionVM.ivaRetenido.toStringAsFixed(2)}'),
                ),
                _customRow(
                  theme,
                  '= Gran total',
                  Text('\$${formCotizacionVM.granTotal.toStringAsFixed(2)}'),
                ),
              ],
            ),
          ),
        ],
        onStepTapped: (int newIndex) {
          setState(() {
            _currentStep = newIndex;
          });
        },
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep != 6) {
            setState(() {
              _currentStep += 1;
            });
          } else {}
        },
        onStepCancel: () {
          if (_currentStep != 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
      ),
    );
  }
}
