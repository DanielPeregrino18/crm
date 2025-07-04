import 'package:crm/presentation/widgets/custom_button.dart';
import 'package:crm/presentation/widgets/custom_date_picker.dart';
import 'package:crm/presentation/widgets/drawer_busqueda.dart';
import 'package:crm/presentation/widgets/expandable_card.dart';
import 'package:crm/presentation/widgets/search_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRM")),
      body: Center(
        child: Column(
          children: [
            CustomButton(
              onPressed: () {
                var res = customHourPicker(
                  context,
                  11,
                  11,
                  "Selecciona la Hora",
                );
              },
              label: "Boton Custom",
            ),
            CustomButton(
              onPressed: () {
                var res = customDatePicker(context);
              },
              label: "Boton fecha",
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 56,
                    child: SearchButton(
                      onPressed: () {
                        debugPrint('Buscar');
                      },
                    ),
                  ),
                ),
              ],
            ),
            ExpandableCard(
              title: Text("Carta"),
              expanded: Text("Mas informacion"),
              estatus: Text("Estatus"),
              onTap: () {},
              child: Text("Informacion"),
            ),
          ],
        ),
      ),
      endDrawer: DrawerBusqueda(
        title: "Busqueda",
        tabBars: {
          "Cliente": Text("Busqueda por cliente"),
          "Movimiento": Text("Busqueda por movimiento"),
        },
      ),
    );
  }
}
