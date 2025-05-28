import 'package:crm/presentation/screens/cotizaciones/cotizaciones.dart';
import 'package:crm/presentation/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) =>
      GoRouter(
          routes: <RouteBase>[
            GoRoute(
                path: '/',
                builder: (context, state) {
                  return Cotizaciones();
                },
            ),
            GoRoute(
              path: '/pedidos',
              builder: (context, state) {
                return Pedidos();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'pedido',
                  builder:
                      (context, state) =>
                  const PedidoScreen(),
                ),
              ],
            )
          ]
      )
  ,);