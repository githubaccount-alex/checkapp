import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../2_application/pruefung_bloc/pruefung_bloc.dart';

class NeuePruefungPage extends StatefulWidget {
  const NeuePruefungPage({super.key});

  @override
  State<NeuePruefungPage> createState() => _NeuePruefungPageState();
}

class _NeuePruefungPageState extends State<NeuePruefungPage> {
  final TextEditingController _prueferController = TextEditingController();

  void _newPruefung() {
    final pruefungBloc = BlocProvider.of<PruefungBloc>(context);
    PruefungEntity pruefungEntity = PruefungEntity(id: UniqueID(), pruefer: _prueferController.text, datum: DateTime.now(), vorlage: _vorlageController.text);
    pruefungBloc.add(InitNewPruefungEvent(pruefungEntity: null));
    context.push(kNeuePruefung);
  }

  @override
  Widget build(BuildContext context) {
    return MainWidget(
        showAppbar: true,
        bottomNavbarIndex: 3,
        appbarTitle: "Neue Prüfung",
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Flexible(
                  child: TextField(
                    controller: _prueferController,
                    decoration: const InputDecoration(
                      labelText: 'Prüfer',
                    ),
                  ),
                ),
                DropdownMenu<String>(
                  initialSelection: pruefungRepository.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),

                ElevatedButton(onPressed: () {
                  _newPruefung();
                }, child: const Text("Weiter"))
              ],
            ),
          ),
        ));
  }
}
