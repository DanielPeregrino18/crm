

import 'package:crm/presentation/home.dart';
import 'package:crm/presentation/screens/cotizaciones/cotizaciones.dart';
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
            )
          ]
      )
  ,);