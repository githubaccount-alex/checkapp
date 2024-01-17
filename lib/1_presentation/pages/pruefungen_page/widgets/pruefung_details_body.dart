import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../../common_widgets/main_widget.dart';
import '../../../routes/paths.dart';

class PruefungDetailsBody extends StatelessWidget {
  final PruefungEntity pruefungEntity;

  const PruefungDetailsBody({super.key, required this.pruefungEntity});

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      showAppbar: true,
      bottomNavbarIndex: 1,
      appbarTitle: "${pruefungEntity.vorlage.titel} : ${DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum)}",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: pruefungEntity.pruefer ?? "Prüfer",
              decoration: InputDecoration(hintText: pruefungEntity.pruefer ?? "Prüfer"),
              onChanged: (value) {
                pruefungEntity.pruefer = value;
              },
            ),
            const SizedBox(height: 10),
            Text(
              DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum),
              style: const TextStyle(fontSize: 20),
            ),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<PruefungBloc>(context).add(EditPruefungDetailsEvent(pruefungEntity: pruefungEntity));
                },
                child: const Text("Speichern")),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<PruefungBloc>(context).add(DeletePruefungDetailsEvent(pruefungEntity: pruefungEntity));
                },
                child: const Text("Löschen")),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: pruefungEntity.vorlage.objekte.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pruefungEntity.vorlage.objekte[index].titel),
                      subtitle: TextFormField(
                        initialValue: pruefungEntity.vorlage.objekte[index].kommentar ?? "IO",
                        decoration: InputDecoration(hintText: pruefungEntity.vorlage.objekte[index].kommentar ?? "IO"),
                        onChanged: (value) {
                          pruefungEntity.vorlage.objekte[index].kommentar = value;
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}