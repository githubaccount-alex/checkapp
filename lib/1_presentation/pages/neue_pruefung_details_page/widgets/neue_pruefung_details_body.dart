import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../../routes/paths.dart';

class NeuePruefungDetailsBody extends StatelessWidget {
  final PruefungEntity pruefungEntity;

  const NeuePruefungDetailsBody({super.key, required this.pruefungEntity});

  @override
  Widget build(BuildContext context) {

    void _savePruefung() {
      BlocProvider.of<PruefungBloc>(context).add(EditPruefungEvent(pruefungEntity: pruefungEntity));
      context.push(kPruefungen);
    }

    void _deletePruefung() {
      BlocProvider.of<PruefungBloc>(context).add(DeletePruefungEvent(pruefungEntity: pruefungEntity));
      context.push(kPruefungen);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(pruefungEntity.pruefer, style: const TextStyle(fontSize: 25)),
          Text(DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum), style: const TextStyle(fontSize: 20),),
          const Divider(),
          ElevatedButton(onPressed: _savePruefung, child: const Text("Speichern")),
          const Divider(),
          ElevatedButton(onPressed: _deletePruefung, child: const Text("Löschen")),
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
    );
  }
}
