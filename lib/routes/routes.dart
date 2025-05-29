import 'package:crm/presentation/screens/cotizaciones/cotizaciones.dart';
import 'package:crm/presentation/screens/cotizaciones/form_cotizacion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/pedidos/pedido/pedido.dart';
import '../presentation/screens/pedidos/pedidos.dart';

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
        path: '/pedidos',
        builder: (context, state) {
          return Pedidos();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'pedido',
            builder: (context, state) => const PedidoScreen(),
          ),
        ],
      ),
    ],
  ),
);
