import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../0_common/theme/theme_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                  child: InkWell(
                    onTap: () {
                      context.go(kPruefungen);
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_box), // Add your icon here
                            SizedBox(height: 8),
                            Text("Prüfungen"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      context.go(kNeuePruefung);
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(height: 8),
                            Text("Neue Prüfung"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      context.go(kPruefungen);
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.ad_units),
                            SizedBox(height: 8),
                            Text("Vorlagen"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                themeProvider.toggleTheme();
                              });
                            },
                          ),
                          Text("Light / Darkmode"),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
