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
    ClienteModelo(6, "GREEN MOTION", "MARTE AUTORENTAS", "MAU071220MR3")
  ];

  List<ClienteModelo> getClientesFiltro(String search){
    return clientes.where((cliente) => 
        cliente.nombre.toLowerCase().contains(search.toLowerCase()) ||
        cliente.razonSocial.toLowerCase().contains(search.toLowerCase()) ||
        cliente.rfc.toLowerCase().contains(search.toLowerCase())
      ,).toList();
  }
}