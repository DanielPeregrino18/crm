import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/cliente_modelo.dart';

final clienteVMProvider = ChangeNotifierProvider<ClienteVM>( (ref) =>
                            ClienteVM(),);
class ClienteVM extends ChangeNotifier{

  List<ClienteModelo> clientes = [
    ClienteModelo(1, "CLIENTE DE CONTADO", "CLIENTE DE CONTADO", "XAXX010101000"),
    ClienteModelo(2806, "RUBEN GARCIA ORTEGA", "RUBEN GARCIA ORTEGA", "GAOR701211919"),
    ClienteModelo(5475, "JORGE ENRIQUE BOLAÑOS BORGES", "JORGE ENRIQUE BOLAÑOS BORGES", "BOBJ551213RB9"),
    ClienteModelo(8687, "OCTAVIO MUÑOZ LOYA", "OCTAVIO MUÑOZ LOYA", "MULO740410CMA"),
    ClienteModelo(9634, "PROPOLIALIMENTOS", "PROPOLIALIMENTOS", "PRO050517TY3"),
    ClienteModelo(17044, "JOSE ALFREDO ORTIZ MARTINEZ", "JOSE ALFREDO ORTIZ MARTINEZ", "OIMA611108CT3"),
    ClienteModelo(33287, "GUSTEAU INTERNATIONAL", "GUSTEAU INTERNATIONAL", "GIN161111QU8"),
    ClienteModelo(34448, "ERIC MAGNO ACOSTA CAMACHO", "ERIC MAGNO ACOSTA CAMACHO", "AOCE5903126J7"),
    ClienteModelo(44886, "MARIA DE JESUS SAUCEDO ROBLES", "MARIA DE JESUS SAUCEDO ROBLES", "SARJ870521K64"),
    ClienteModelo(45236, "PROYECTOS SEREIN.", "PROYECTOS SEREIN", "PSE190930123"),
    ClienteModelo(56086, "CLAUDIA ELIZABETH GARCIA ZAMORA", "CLAUDIA ELIZABETH GARCIA ZAMORA", "GAZC860320NW6"),

  ];

  List<ClienteModelo> getClientesFiltro(String search){
    return clientes.where((cliente) => 
        cliente.nombre.toLowerCase().contains(search.toLowerCase()) ||
        cliente.razonSocial.toLowerCase().contains(search.toLowerCase()) ||
        cliente.rfc.toLowerCase().contains(search.toLowerCase())
      ,).toList();
  }
}