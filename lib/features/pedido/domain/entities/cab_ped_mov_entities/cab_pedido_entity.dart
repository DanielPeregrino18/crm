import 'package:equatable/equatable.dart';

class CabPedidoEntity extends Equatable {
  final int? ID_ALMACEN;
  final int? ID_PEDIDO;
  final DateTime? FECHA;
  final int? ID_VENDEDOR;
  final int? ID_CLIENTE;
  final int? ID_CTE_FACTURA;
  final double? PARIDAD;
  final double? DESCUENTO_GLOBAL;
  final String? ID_TIPO_PEDIDO;
  final bool? ENTREGA_DOMICILIO;
  final String? OBSERVACIONES;
  final String? ESTATUS;
  final int? ID_NUMREFERENCIA;
  final DateTime? FECHA_MOVIMIENTO;
  final int? ID_SUCURSAL_CTE;
  final double? CARGO_FLETE;
  final double? MANEJO_CUENTA;
  final bool? MUESTRA_PUBLICO_GRAL;
  final double? SUBTOTAL;
  final double? IVA;
  final double? DESCUENTO;
  final int? DiasCredito;
  final double? TipoCambio;
  final String? Entrega;
  final String? OrdenCompra;
  final int? NUM_FACTURAS;
  final DateTime? FECHA_CANCELACION;
  final String? ESTATUS_PROCESO;
  final int? SURTIO;
  final DateTime? FECHA_ENTREGA;
  final DateTime? FECHA_ASIGNACION;
  final DateTime? FECHA_SURTIDO;
  final DateTime? FECHA_SALIDA;
  final DateTime? FECHA_CLIENTE;
  final double? IVA_CTA;
  final double? PORIVA_CTA;
  final bool? Autorizada;
  final int? Id_Usuario_Autoriza;
  final bool? Req_Autorizacion;
  final String? ATENCION;
  final int? ID_COTIZACION;
  final int? ID_COTIZACION_ALMACEN;
  final int? PEDIDOWEB;
  final String? MOV_ANT;
  final String? EntregarEnDomicilio;
  final String? EntregarEnColonia;
  final String? EntregarEnCP;
  final String? EntregarEnCiudad;
  final String? EntregarEnEstado;
  final String? EntregarEnCalles;
  final bool? ImprimirSinPrecios;
  final DateTime? FECHA_REGISTRO;
  final String? Nombre;
  final int? Id_Gravamen;
  final String? CampoAddenda;
  final bool? Apartado;
  final DateTime? FECHA_INICIOC;
  final DateTime? FECHA_FINC;
  final DateTime? FECHA_OC;
  final DateTime? FECHAENTREGA;
  final double? IEPS;
  final bool? RETIENE_IVA;
  final double? IVA_RETENIDO_TOTAL;
  final int? ID_PRIORIDAD;
  final int? ID_TIPO_ENTREGA;
  final String? OC_PATH;
  final String? USO_CFDI;
  final bool? VENTAS_PLAZOS;
  final int? ID_USUARIO_CREO;
  final int? ID_MOTIVO_CANC;
  final bool? IVA_INTERIOR;

  const CabPedidoEntity({
    this.ID_ALMACEN,
    this.ID_PEDIDO,
    this.FECHA,
    this.ID_VENDEDOR,
    this.ID_CLIENTE,
    this.ID_CTE_FACTURA,
    this.PARIDAD,
    this.DESCUENTO_GLOBAL,
    this.ID_TIPO_PEDIDO,
    this.ENTREGA_DOMICILIO,
    this.OBSERVACIONES,
    this.ESTATUS,
    this.ID_NUMREFERENCIA,
    this.FECHA_MOVIMIENTO,
    this.ID_SUCURSAL_CTE,
    this.CARGO_FLETE,
    this.MANEJO_CUENTA,
    this.MUESTRA_PUBLICO_GRAL,
    this.SUBTOTAL,
    this.IVA,
    this.DESCUENTO,
    this.DiasCredito,
    this.TipoCambio,
    this.Entrega,
    this.OrdenCompra,
    this.NUM_FACTURAS,
    this.FECHA_CANCELACION,
    this.ESTATUS_PROCESO,
    this.SURTIO,
    this.FECHA_ENTREGA,
    this.FECHA_ASIGNACION,
    this.FECHA_SURTIDO,
    this.FECHA_SALIDA,
    this.FECHA_CLIENTE,
    this.IVA_CTA,
    this.PORIVA_CTA,
    this.Autorizada,
    this.Id_Usuario_Autoriza,
    this.Req_Autorizacion,
    this.ATENCION,
    this.ID_COTIZACION,
    this.ID_COTIZACION_ALMACEN,
    this.PEDIDOWEB,
    this.MOV_ANT,
    this.EntregarEnDomicilio,
    this.EntregarEnColonia,
    this.EntregarEnCP,
    this.EntregarEnCiudad,
    this.EntregarEnEstado,
    this.EntregarEnCalles,
    this.ImprimirSinPrecios,
    this.FECHA_REGISTRO,
    this.Nombre,
    this.Id_Gravamen,
    this.CampoAddenda,
    this.Apartado,
    this.FECHA_INICIOC,
    this.FECHA_FINC,
    this.FECHA_OC,
    this.FECHAENTREGA,
    this.IEPS,
    this.RETIENE_IVA,
    this.IVA_RETENIDO_TOTAL,
    this.ID_PRIORIDAD,
    this.ID_TIPO_ENTREGA,
    this.OC_PATH,
    this.USO_CFDI,
    this.VENTAS_PLAZOS,
    this.ID_USUARIO_CREO,
    this.ID_MOTIVO_CANC,
    this.IVA_INTERIOR,
  });

  @override
  List<Object?> get props {
    return [
      ID_ALMACEN,
      ID_PEDIDO,
      FECHA,
      ID_VENDEDOR,
      ID_CLIENTE,
      ID_CTE_FACTURA,
      PARIDAD,
      DESCUENTO_GLOBAL,
      ID_TIPO_PEDIDO,
      ENTREGA_DOMICILIO,
      OBSERVACIONES,
      ESTATUS,
      ID_NUMREFERENCIA,
      FECHA_MOVIMIENTO,
      ID_SUCURSAL_CTE,
      CARGO_FLETE,
      MANEJO_CUENTA,
      MUESTRA_PUBLICO_GRAL,
      SUBTOTAL,
      IVA,
      DESCUENTO,
      DiasCredito,
      TipoCambio,
      Entrega,
      OrdenCompra,
      NUM_FACTURAS,
      FECHA_CANCELACION,
      ESTATUS_PROCESO,
      SURTIO,
      FECHA_ENTREGA,
      FECHA_ASIGNACION,
      FECHA_SURTIDO,
      FECHA_SALIDA,
      FECHA_CLIENTE,
      IVA_CTA,
      PORIVA_CTA,
      Autorizada,
      Id_Usuario_Autoriza,
      Req_Autorizacion,
      ATENCION,
      ID_COTIZACION,
      ID_COTIZACION_ALMACEN,
      PEDIDOWEB,
      MOV_ANT,
      EntregarEnDomicilio,
      EntregarEnColonia,
      EntregarEnCP,
      EntregarEnCiudad,
      EntregarEnEstado,
      EntregarEnCalles,
      ImprimirSinPrecios,
      FECHA_REGISTRO,
      Nombre,
      Id_Gravamen,
      CampoAddenda,
      Apartado,
      FECHA_INICIOC,
      FECHA_FINC,
      FECHA_OC,
      FECHAENTREGA,
      IEPS,
      RETIENE_IVA,
      IVA_RETENIDO_TOTAL,
      ID_PRIORIDAD,
      ID_TIPO_ENTREGA,
      OC_PATH,
      USO_CFDI,
      VENTAS_PLAZOS,
      ID_USUARIO_CREO,
      ID_MOTIVO_CANC,
      IVA_INTERIOR,
    ];
  }
}
