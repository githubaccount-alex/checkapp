import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../0_common/theme/theme_provider.dart';
import '../routes/paths.dart';

class MainWidget extends StatelessWidget {
  final bool showAppbar;
  final Widget child;
  final Widget? leadingWidget;
  final String? appbarTitle;
  final int? bottomNavbarIndex;
  final Widget? floatingActionButton;

  const MainWidget({super.key, required this.showAppbar, required this.child, this.leadingWidget, this.appbarTitle, this.bottomNavbarIndex = -1, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: showAppbar
            ? AppBar(
                leading: leadingWidget,
                automaticallyImplyLeading: false,
                //backgroundColor: Colors.pink[700],
                title: Text(
                  appbarTitle ?? "Check App ?",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : null,
        body: child,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavbarIndex == -1 ? 0 : bottomNavbarIndex!,
            onTap: (index) {
              String currentRoute = "/${ModalRoute.of(context)!.settings.name!}";
              if (index == 0 && kDashboard != currentRoute) {
                context.go(kDashboard);
              } else if (index == 1 && kPruefungen != currentRoute) {
                context.go(kPruefungen);
              } else if (index == 2 && kNeuePruefung != currentRoute) {
                context.go(kNeuePruefung);
              } else if (index == 3 && kVorlagen != currentRoute) {
                context.go(kVorlagen);
              } else if (index == 4 && kEinstellungen != currentRoute) {
                context.go(kEinstellungen);
              }
            },
            selectedItemColor: bottomNavbarIndex == -1 ? Colors.grey : Colors.pink.shade400,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Prüfungen',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Neue Prüfung',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ad_units),
                label: 'Vorlagen',
              ),
              /*BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Einstellungen',
              ),*/
            ]));
  }
}
