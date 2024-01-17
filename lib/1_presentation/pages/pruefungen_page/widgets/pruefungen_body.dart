import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../../../2_application/snackbar_bloc/snackbar_bloc.dart';
import '../../../../3_domain/entities/id.dart';
import '../../../../3_domain/entities/pruefung_entity.dart';
import '../../../../3_domain/entities/vorlage_entity.dart';
import '../../../common_widgets/main_widget.dart';
import '../../../routes/paths.dart';

class PruefungenBody extends StatefulWidget {
  final List<PruefungEntity> pruefungen;
  final List<VorlageEntity> vorlagen;

  const PruefungenBody({super.key, required this.pruefungen, required this.vorlagen});

  @override
  State<PruefungenBody> createState() => _PruefungenBodyState();
}

class _PruefungenBodyState extends State<PruefungenBody> {
  late VorlageEntity? selectedVorlage;

  Future<VorlageEntity?> _showSelectionDialog(BuildContext context, List<VorlageEntity> vorlagen) async {
    return showDialog<VorlageEntity>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wähle eine Vorlage aus'),
          content: Column(
            children: vorlagen.map((item) {
              return ListTile(
                title: Text(item.titel),
                onTap: () {
                  Navigator.of(context).pop(item);
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      showAppbar: true,
      bottomNavbarIndex: 1,
      appbarTitle: "Prüfungen",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
              heroTag: "btn1",
              onPressed: () {
                BlocProvider.of<PruefungBloc>(context).add(ExportPruefungenToCsv());
                BlocProvider.of<SnackbarBloc>(context).add(SendSnackbarEvent(message: 'Prüfungen wurden exportiert'));
              },
              icon: const Icon(Icons.list, color: Colors.white),
              label: const Text("Export to CSV")),
          const SizedBox(height: 10,),
          FloatingActionButton.extended(
            heroTag: "btn2",
            onPressed: () async {
              if (widget.vorlagen.isEmpty) {
                BlocProvider.of<PruefungBloc>(context).add(NoVorlagenForPruefungEvent());
              } else {
                selectedVorlage = await _showSelectionDialog(context, widget.vorlagen);
                if (selectedVorlage != null) {
                  PruefungEntity emptyPruefung = PruefungEntity(id: UniqueID(), pruefer: null, datum: DateTime.now(), vorlage: selectedVorlage!);
                  BlocProvider.of<PruefungBloc>(context).add(CreateNewPruefungDetailsEvent(pruefungEntity: emptyPruefung));
                }
              }
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Prüfung hinzufügen"),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: widget.pruefungen.length,
        itemBuilder: (context, index) {
          PruefungEntity pruefungEntity = widget.pruefungen[index];
          return ListTile(
            title: Text("${pruefungEntity.vorlage.ort}, ${pruefungEntity.vorlage.ort_detail}"),
            subtitle: Text(DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum)),
            onTap: () {
              BlocProvider.of<PruefungBloc>(context).add(LoadPruefungDetailsEvent(pruefungEntity: pruefungEntity));
            },
          );
        },
      ),
    );
  }
}
