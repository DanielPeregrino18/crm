import 'package:crm/presentation/viewmodels/cotizaciones/form_cotizacion_vm.dart';
import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:crm/presentation/widgets/search_bar_clientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/menu_almacenes_periodo/widgets/almacenes/menu_almacenes.dart';

class FormCotizacion extends ConsumerStatefulWidget {
  const FormCotizacion({Key? key}) : super(key: key);

  @override
  ConsumerState<FormCotizacion> createState() => _FormCotizacionState();
}

class _FormCotizacionState extends ConsumerState<FormCotizacion> {
  int _currentStep = 0;

  TextFormField _customTextField(
    ColorScheme theme,
    String label,
    bool isEnabled,
    TextEditingController textController,
  ) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: theme.primary.withAlpha(15),
        label: Text(label),
        floatingLabelStyle: TextStyle(fontSize: 20),
      ),
      enabled: isEnabled,
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
    {"nombre": "Prueba", "id": 2},
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
                            _currentStep == 4 ? 'Finalizar' : 'Siguiente',
                          ),
                        ),
                      ],
                    ),
          );
        },
        steps: [
          Step(
            isActive: _currentStep == 0,
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
                      "almacen",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      if (isEnabled) {
                        mostrarMenu(
                          MenuAlmacenes(setAlmacen: (int id, String nombre) {}),
                          false,
                        );
                      }
                    },
                  ),
                ),
                //todo colocar el vendedor aqui
                SearchBarClientes(
                  hint: "Cliente",
                  actions: [],
                  inputController: formCotizacionVM.clienteController,
                  setIdCliente: (id) {},
                  initialValue: formCotizacionVM.nombre,
                ),
                _customTextField(
                  theme,
                  'Sucursal',
                  false,
                  formCotizacionVM.sucursalController,
                ),
                _customTextField(
                  theme,
                  'Dirección',
                  false,
                  formCotizacionVM.direccionController,
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
                      setState(() {
                        formCotizacionVM.idListaPrecios = value as int;
                      });
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
                      var date = await customDatePicker(context);
                      if (date != null) {
                        setState(() {
                          formCotizacionVM.fechaVigencia = date;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 1,
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
                        var date = await customDatePicker(context);
                        if (date != null) {
                          setState(() {
                            formCotizacionVM.fechaOrdenCompra = date;
                          });
                        }
                      }
                    },
                  ),
                ),
                _customTextField(
                  theme,
                  'No. de Serie',
                  isEnabled,
                  formCotizacionVM.noSerieController,
                ),
                _customTextField(
                  theme,
                  'Orden de compra',
                  isEnabled,
                  formCotizacionVM.ordenCompraController,
                ),
                _customTextField(
                  theme,
                  'Procesado',
                  false,
                  formCotizacionVM.procesadoController,
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 2,
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
                _customTextField(
                  theme,
                  'RFC',
                  false,
                  formCotizacionVM.rfcController,
                ),
                _customTextField(
                  theme,
                  'Plazo',
                  false,
                  formCotizacionVM.plazoController,
                ),
                _customTextField(
                  theme,
                  'Descuento',
                  isEnabled,
                  formCotizacionVM.descuentoController,
                ),
                //_customTextField(theme, 'Moneda', true, ), todo cambiarlo a dropdown
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
                      setState(() {
                        formCotizacionVM.idMoneda = value as int;
                      });
                    },
                  ) : Text('${listaMonedas.firstWhere((element) => element['id'] == formCotizacionVM.idMoneda,)['nombre']}'),
                ),
                _customTextField(
                  theme,
                  'Paridad',
                  false,
                  formCotizacionVM.paridadController,
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 3,
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
                        var fechaInicioConsigna = await customDatePicker(
                          context,
                        );
                        if (fechaInicioConsigna != null) {
                          setState(() {
                            formCotizacionVM.fechaInicioConsigna =
                                fechaInicioConsigna;
                          });
                        }
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
                        var fechaFinConsigna = await customDatePicker(context);
                        if (fechaFinConsigna != null) {
                          setState(() {
                            formCotizacionVM.fechaFinConsigna =
                                fechaFinConsigna;
                          });
                        }
                      }
                    },
                  ),
                ),
                _customTextField(
                  theme,
                  'Campo addenda',
                  isEnabled,
                  formCotizacionVM.campoAddendaController,
                ),
                // Observaciones
                _customTextField(
                  theme,
                  'Observaciones',
                  isEnabled,
                  formCotizacionVM.observacionesController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCheckBox(
                      text: 'Autorizar',
                      value: formCotizacionVM.autorizar,
                      onChange: (val) {
                        if (isEnabled) {
                          setState(() {
                            formCotizacionVM.autorizar = val;
                          });
                        }
                      },
                    ),
                    CustomCheckBox(
                      text: 'IVA Total Retenido',
                      value: formCotizacionVM.ivaTotalRetenido,
                      onChange: (val) {
                        if (isEnabled) {
                          setState(() {
                            formCotizacionVM.ivaTotalRetenido = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 4,
            title: Text('Domicilio'),
            content: Column(
              spacing: 15,
              children: [
                _customTextField(
                  theme,
                  'Domicilio',
                  true,
                  formCotizacionVM.domicilioController,
                ),
                _customTextField(
                  theme,
                  'Colonia',
                  true,
                  formCotizacionVM.coloniaController,
                ),
                _customTextField(
                  theme,
                  'Estado',
                  true,
                  formCotizacionVM.estadoController,
                ),
                _customTextField(
                  theme,
                  'Ciudad',
                  true,
                  formCotizacionVM.ciudadController,
                ),
                _customTextField(
                  theme,
                  'Entre calles',
                  true,
                  formCotizacionVM.entreCallesController,
                ),
                _customTextField(
                  theme,
                  'Atención a',
                  isEnabled,
                  formCotizacionVM.atencionAContoller,
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
                      var fechaEntrega = await customDatePicker(context);
                      if (fechaEntrega != null) {
                        setState(() {
                          formCotizacionVM.fechaEntrega = fechaEntrega;
                        });
                      }
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
                      var horaEntrega = await customHourPicker(
                        context,
                        formCotizacionVM.horaEntrega.hour,
                        formCotizacionVM.horaEntrega.minute,
                        "Hora de entrega",
                      );
                      if (horaEntrega != null) {
                        setState(() {
                          formCotizacionVM.horaEntrega = horaEntrega;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 4,
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
            isActive: _currentStep == 5,
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
          if (_currentStep != 5) {
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
