import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../../2_application/vorlage_bloc/vorlage_bloc.dart';
import '../../../3_domain/entities/vorlage_entity.dart';
import '../../common_widgets/error_message.dart';

class NeuePruefungPage extends StatefulWidget {
  const NeuePruefungPage({super.key});

  @override
  State<NeuePruefungPage> createState() => _NeuePruefungPageState();
}

class _NeuePruefungPageState extends State<NeuePruefungPage> {
  final TextEditingController _prueferController = TextEditingController();
  late VorlageEntity dropdownValue;

  @override
  Widget build(BuildContext context) {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context)..add(LoadVorlagenEvent());

    void _newPruefung() {
      final pruefungBloc = BlocProvider.of<PruefungBloc>(context);
      PruefungEntity pruefungEntity = PruefungEntity(id: UniqueID(), pruefer: _prueferController.text, datum: DateTime.now(), vorlage: dropdownValue);
      pruefungBloc.add(NewPruefungEvent(pruefungEntity: pruefungEntity));
      context.push(kNeuePruefungDetails);
    }

    return MainWidget(
        showAppbar: true,
        bottomNavbarIndex: 2,
        appbarTitle: "Neue Prüfung",
        leadingWidget: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.push(kDashboard);
          },
        ),
        child: BlocBuilder<VorlageBloc, VorlageState>(
          bloc: vorlageBloc,
          builder: (context, state) {
            if (state is VorlagenLoadedState && state.vorlagen.isEmpty) {
              return const Center(child: Text("Es gibt noch keine Vorlagen, bitte anlegen"));
            } else if (state is VorlagenLoadedState && state.vorlagen.isNotEmpty) {
              dropdownValue = state.vorlagen.first;
              return Padding(
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Wähle eine Vorlage aus:"),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownMenu<VorlageEntity>(
                      initialSelection: state.vorlagen.first,
                      onSelected: (VorlageEntity? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries: state.vorlagen.map<DropdownMenuEntry<VorlageEntity>>((VorlageEntity vorlage) {
                        return DropdownMenuEntry<VorlageEntity>(
                          value: vorlage,
                          label: vorlage.titel,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _newPruefung();
                        },
                        child: const Text("Weiter"))
                  ],
                ),
              );
            } else if (state is VorlageErrorState) {
              return Center(child: ErrorMessage(message: state.errorMessage));
            }
            return Center(child: CircularProgressIndicator(color: Colors.pink.shade400,));
          },
        ));
  }
}
