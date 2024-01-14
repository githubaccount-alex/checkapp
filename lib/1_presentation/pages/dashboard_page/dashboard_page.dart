import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWidget(
        showAppbar: true,
        appbarTitle: "Dashboard",
        bottomNavbarIndex: 0,
        leadingWidget: null,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  child: InkWell(onTap: () {
                    context.go(kPruefungen);
                      }, child: const SizedBox(width: 300, height: 100, child: Center(child: Text("Prüfungen")))),
                ),
                Card(
                  child: InkWell(onTap: () {
                    context.go(kNeuePruefung);
                  }, child: const SizedBox(width: 300, height: 100, child: Center(child: Text("Neue Prüfung")))),
                ),
                Card(
                  child: InkWell(onTap: () {
                    context.go(kVorlagen);
                  }, child: const SizedBox(width: 300, height: 100, child: Center(child: Text("Vorlage")))),
                ),
                Card(
                  child: InkWell(onTap: () {
                    context.go(kEinstellungen);
                  }, child: const SizedBox(width: 300, height: 100, child: Center(child: Text("Einstellungen")))),
                ),
              ],
            ),
          ),
        ));
  }
}
