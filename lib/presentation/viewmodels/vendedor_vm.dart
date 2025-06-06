import 'package:crm/data/models/vendedor_modelo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendedorVMProvider = ChangeNotifierProvider<VendedorVM>((ref) =>
                                                   VendedorVM() ,);
class VendedorVM extends ChangeNotifier{

  List<VendedorModelo> vendedores = [
    VendedorModelo(4, "SERGIOV"),
    VendedorModelo(66, "EDUARDO_CORTES_ORAN"),
    VendedorModelo(125, "ANGELA_MORALES_SALIDO"),
    VendedorModelo(131, "JAIME_ANDUJO_GUTIERREZ"),
    VendedorModelo(148, "JAZIEL_ALVARADO"),
    VendedorModelo(152, "JAVIER_ELIAS_CARRERA"),
    VendedorModelo(163, "AARON_ALEJANDRO_MEDINA"),
  ];

  List<VendedorModelo> getVendedoresFiltro(String search){
    return vendedores.where((vendedor) =>
        vendedor.nombre.toLowerCase().contains(search.toLowerCase()),).toList();
  }
}