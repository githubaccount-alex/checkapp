import 'package:checkapp/1_presentation/pages/pruefungen_page/pruefungen_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/dashboard_page/dashboard_page.dart';
import '../pages/vorlagen_page/vorlagen_page.dart';

class MyRoutes {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardPage();
            },
          ),
          GoRoute(
            path: 'vorlagen',
            builder: (BuildContext context, GoRouterState state) {
              return const VorlagenPage();
            },
          ),
          GoRoute(
            path: 'pruefungen',
            builder: (BuildContext context, GoRouterState state) {
              return const PruefungenPage();
            },
          ),
        ],
      ),
    ],
  );
}
