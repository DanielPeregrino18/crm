import 'package:crm/presentation/screens/cotizaciones/cotizaciones.dart';
import 'package:crm/presentation/screens/cotizaciones/form_cotizacion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:crm/presentation/screens/screens.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return Cotizaciones();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'vercotizacion',
            builder: (context, state) => const FormCotizacion(),
          ),
        ],
      ),
      GoRoute(
        path: '/pedido',
        builder: (context, state) {
          return Pedido();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'nuevo_detalle_pedido',
            builder: (context, state) => NuevoDetallePedido(),
          ),
        ],
      ),
    ],
  ),
);
