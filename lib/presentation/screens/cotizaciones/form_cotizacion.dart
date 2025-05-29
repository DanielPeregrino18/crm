import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/presentation/viewmodels/cotizaciones/form_cotizacion_vm.dart';
import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:crm/presentation/widgets/search_bar_clientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/menu_almacenes_periodo/widgets/menu_almacenes.dart';

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
      TextEditingController textController
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

  bool _isEnabled() => true;

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final formCotizacionVM = ref.watch(formCotizacionVMProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        iconTheme: IconThemeData(color: theme.onPrimary),
        title: Text(
          true ? 'Nueva Cotización' : 'Detalles Cotización',
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
                            _currentStep == 5
                                ? true //todo hacer que sea dinamico
                                    ? 'Finalizar'
                                    : 'Cerrar'
                                : 'Siguiente',
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
                      if (true) {
                        //todo solamente cuando sea nuevo se puede seleccionar
                        mostrarMenu(MenuAlmacenes(theme: theme), false);
                      }
                    },
                  ),
                ),
                //_customTextField(theme, 'Cliente', _isEnabled(), "", ),
                //_customTextField(theme, 'Vendedor', true, ""),
                SearchBarClientes(hint: "", actions: [], inputController: formCotizacionVM.clienteController, setIdCliente: (id){}),
                _customTextField(theme, 'Sucursal', false,  formCotizacionVM.sucursalController),
                _customTextField(theme, 'Atención a', true,  formCotizacionVM.atencionAController),
                // Dirección
                _customTextField(theme, 'Dirección', _isEnabled(), formCotizacionVM.direccionController),
                // Lista de precios
                //_customTextField(theme, 'Lista de precios', true,  formCotizacionVM.listaPreciosController), todo cambiarlo a dropown
                CustomButton(onPressed: (){
                  formCotizacionVM.met();
                  setState(() {});
                }, label: "prueba")
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
                      var date = await customDatePicker(context);
                      if(date != null){
                        setState(() {
                          formCotizacionVM.fechaOrdenCompra = date;
                        });
                      }
                    },
                  ),
                ),
                _customTextField(
                  theme,
                  'No. de Serie',
                  true,
                  formCotizacionVM.noSerieController,
                ),
                _customTextField(
                  theme,
                  'Orden de compra',
                  _isEnabled(),
                  formCotizacionVM.ordenCompraController,
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
                  'Pedido',
                  Text(''),
                ),
                _customRow(
                  theme,
                  'Estatus',
                  Text(
                    'NUEVO',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                _customTextField(theme, 'RFC', true, formCotizacionVM.rfcController),
                _customTextField(theme, 'Plazo', true, formCotizacionVM.plazoController),
                _customTextField(theme, 'Descuento', false, formCotizacionVM.descuentoController),
                //_customTextField(theme, 'Moneda', true, ), todo cmbiarlo a dropdown
                _customTextField(theme, 'Paridad', true, formCotizacionVM.paridadController),
              ],
            ),
          ),
          /*Step(
            isActive: _currentStep == 3,
            title: Text('Datos del Pedido'),
            subtitle: Text('4/4'),
            content: Column(
              spacing: 15,
              children: [
                _customRow(
                  theme,
                  'Fecha inicio consigna',
                  TextButton(
                    child: Text(
                      "28/05/2025",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      //if (pedido == null) {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now(),
                        );
                      //}
                    },
                  ),
                ),
                // Fecha fin consigna
                _customRow(
                  theme,
                  'Fecha fin consigna',
                  TextButton(
                    child: Text(
                      "28/05/2025",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      //if (pedido == null) {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now(),
                        );
                      //}
                    },
                  ),
                ),
                // Campo addenda
                _customTextField(
                  theme,
                  'Campo addenda',
                  true,
                  "",
                ),
                // Observaciones
                _customTextField(
                  theme,
                  'Observaciones',
                  true,
                  "",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCheckBox(
                      theme: theme,
                      text: 'Autorizar',
                      value: false,
                    ),
                    CustomCheckBox(
                      theme: theme,
                      text: 'IVA Total Retenido',
                      value: true,
                    ),
                  ],
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
                  Text('\$388.90'),
                ),
                _customRow(
                  theme,
                  '- Descuento total',
                  Text('\$0.00'),
                ),
                _customRow(
                  theme,
                  '+ IEPS Total',
                  Text('\$0.00'),
                ),
                _customRow(
                  theme,
                  '+ Importe con descuento',
                  Text('\$388.90'),
                ),
                _customRow(
                  theme,
                  '+ IVA Total',
                  Text('\$62.23'),
                ),
                _customRow(
                  theme,
                  '- IVA retenido',
                  Text('\$0.00'),
                ),
                // Gran Total
                _customRow(
                  theme,
                  '= Gran total',
                  Text('\$451.13'),
                ),
              ],
            ),
          ),*/



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
          } else {
            Navigator.pop(context);
            //if (pedido == null) {
            //mostrarMenu(ConfirmationWidget(), true);
            //}
          }
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
