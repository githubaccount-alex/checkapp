import 'package:checkapp/1_presentation/pages/neue_pruefung_details_page/neue_pruefung_details_page.dart';
import 'package:checkapp/1_presentation/pages/pruefungen_page/pruefungen_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/dashboard_page/dashboard_page.dart';
import '../pages/einstellungen_page/einstellungen_page.dart';
import '../pages/kommentare_page/kommentare_page.dart';
import '../pages/neue_pruefung_page/neue_pruefung_page.dart';
import '../pages/objekt_page/objekt_page.dart';
import '../pages/pruefer_page/pruefer_page.dart';
import '../pages/vorlage_details_page/vorlage_details_page.dart';
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
            path: 'neue_pruefung',
            builder: (BuildContext context, GoRouterState state) {
              return const NeuePruefungPage();
            },
          ),
          GoRoute(
            path: 'einstellungen',
            builder: (BuildContext context, GoRouterState state) {
              return const EinstellungenPage();
            },
          ),
          GoRoute(
            path: 'kommentare',
            builder: (BuildContext context, GoRouterState state) {
              return const KommentarePage();
            },
          ),
          GoRoute(
            path: 'pruefer',
            builder: (BuildContext context, GoRouterState state) {
              return const PrueferPage();
            },
          ),
          GoRoute(
            path: 'pruefungen',
            builder: (BuildContext context, GoRouterState state) {
              return const PruefungenPage();
            },
          ),
          GoRoute(
            path: 'vorlage_details',
            builder: (BuildContext context, GoRouterState state) {
              return const VorlageDetailsPage();
            },
          ),
          GoRoute(
            path: 'objekt',
            builder: (BuildContext context, GoRouterState state) {
              return const ObjektPage();
            },
          ),
          GoRoute(
            path: 'neue_pruefung_details',
            builder: (BuildContext context, GoRouterState state) {
              return const NeuePruefungDetailsPage();
            },
          ),
        ],
      ),
    ],
  );
}
