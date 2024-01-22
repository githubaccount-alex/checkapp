import 'dart:developer';

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
    final pruefungBloc = BlocProvider.of<PruefungBloc>(context);

    return PopScope(
      onPopInvoked: (bool _) {
        pruefungBloc.add(EditPruefungDetailsEvent(pruefungEntity: pruefungEntity));
      },
      child: MainWidget(
        showAppbar: true,
        bottomNavbarIndex: 1,
        appbarTitle: "${pruefungEntity.vorlage.titel} : ${DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum)}",
        leadingWidget: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.push(kDashboard);
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  pruefungBloc.add(AddImageFromCameraToPruefungDetailsEvent(pruefungEntity: pruefungEntity));
                },
                child: const Icon(Icons.camera_alt, color: Colors.white)),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  pruefungBloc.add(AddImageFromGalleryToPruefungDetailsEvent(pruefungEntity: pruefungEntity));
                },
                child: const Icon(Icons.file_copy, color: Colors.white)),
          ],
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      pruefungBloc.add(EditPruefungDetailsEvent(pruefungEntity: pruefungEntity));
                    },
                    child: const Text("Speichern")),
                const SizedBox(
                  width: 20,
                ),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      pruefungBloc.add(DeletePruefungDetailsEvent(pruefungEntity: pruefungEntity));
                    },
                    child: const Text("Löschen")),

              ]),
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
              const Divider(),
              if (pruefungEntity.imageData.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: pruefungEntity.imageData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.memory(
                              pruefungEntity.imageData[index]!,
                              height: 150,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {
                                  pruefungBloc.add(DeleteImageOfPruefungDetailsEvent(pruefungEntity: pruefungEntity, image: pruefungEntity.imageData[index]!));
                                },
                                child: const Text("Löschen")),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
