import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/cliente_modelo.dart';

final clienteVMProvider = ChangeNotifierProvider<ClienteVM>( (ref) =>
                            ClienteVM(),);
class ClienteVM extends ChangeNotifier{

  List<ClienteModelo> clientes = [
    ClienteModelo(1, "VISA CFSA", "CARNES FINAS SAN ANDRES, S.A. DE C.V", "CFS881114KWA"),
    ClienteModelo(2, "RRJ", "RADIO REFRIGERACION DE JUAREZ", "RRJ910111R47"),
    ClienteModelo(3, "GELOS POLITECNICO", "COMERCIALIZADORA GELOS DE CHIHUAHUA", "CGC010606JD6"),
    ClienteModelo(6, "GREEN MOTION", "MARTE AUTORENTAS", "MAU071220MR3"),
    ClienteModelo(8, "PROMOTORA DE AUTOSERVICIOS DE EXCELENCIA S.A. DE C.V.", "PROMOTORA DE AUTOSERVICIOS DE EXCELENCIA S.A. DE C.V.", "PAE021118SA5"),
    ClienteModelo(9, "VISA CCB", "CARNES CASA BLANCA S.A. DE C.V.", "CCB9108169PA"),
    ClienteModelo(11, "HECTOR ALVAREZ DOMINGUEZ JOSESITO", "HECTOR ALVAREZ DOMINGUEZ", "AADH791002P44"),
    ClienteModelo(12, "PAPELERIA ROUHANA S.A. DE C.V.", "MPAPELERIA ROUHANA S.A. DE C.V.", "PR0990629K71"),
    ClienteModelo(13, "ROSA MARIA ORNELAS MUÑOZ", "ROSA MARIA ORNELAS MUÑOZ", "OEMR3405173T4"),
    ClienteModelo(18, "APPLIED MEXICO, S.A. DE C.V.", "APPLIED MEXICO", "AME0010162W9"),
    ClienteModelo(24, "FCU", "FARMACIA CUAUHTEMOC", "FCU930805D64"),
  ];

  List<ClienteModelo> getClientesFiltro(String search){
    return clientes.where((cliente) => 
        cliente.nombre.toLowerCase().contains(search.toLowerCase()) ||
        cliente.razonSocial.toLowerCase().contains(search.toLowerCase()) ||
        cliente.rfc.toLowerCase().contains(search.toLowerCase())
      ,).toList();
  }
}