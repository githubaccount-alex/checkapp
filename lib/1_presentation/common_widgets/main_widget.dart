import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavbarIndex == -1 ? 0 : bottomNavbarIndex!,
            onTap: (index) {
              String currentRoute = "/${ModalRoute.of(context)!.settings.name!}";
              if (index == 0 && kDashboard != currentRoute) {
                context.push(kDashboard);
              } else if (index == 1 && kPruefungen != currentRoute) {
                context.push(kPruefungen);
              } else if (index == 2 && kVorlagen != currentRoute) {
                context.push(kVorlagen);
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
                icon: Icon(Icons.ad_units),
                label: 'Vorlagen',
              ),
            ]));
  }
}
