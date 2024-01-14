import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../2_application/objekt_bloc/objekt_bloc.dart';
import '../../../../3_domain/entities/object_entity.dart';

class ObjektBody extends StatefulWidget {
  final VorlageEntity vorlageEntity;
  final ObjektEntity? objektEntity;

  const ObjektBody({super.key, required this.vorlageEntity, required this.objektEntity});

  @override
  State<ObjektBody> createState() => _ObjektBodyState();
}

class _ObjektBodyState extends State<ObjektBody> {
  final TextEditingController _titelController = TextEditingController();
  final TextEditingController _beschreibungController = TextEditingController();
  final TextEditingController _verantwortlicherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titelController.text = widget.objektEntity?.titel ?? '';
    _beschreibungController.text = widget.objektEntity?.beschreibung ?? '';
    _verantwortlicherController.text = widget.objektEntity?.verantwortlicher ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final objektBloc = BlocProvider.of<ObjektBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Flexible(
            child: TextField(
              controller: _titelController,
              decoration: const InputDecoration(
                labelText: 'Titel',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _beschreibungController,
              decoration: const InputDecoration(
                labelText: 'Beschreibung',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _verantwortlicherController,
              decoration: const InputDecoration(
                labelText: 'Verantwortlicher',
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                if (widget.objektEntity == null) {
                  ObjektEntity objekt =
                      ObjektEntity(id: UniqueID(), titel: _titelController.text, beschreibung: _beschreibungController.text, verantwortlicher: _verantwortlicherController.text, kommentar: null);
                  objektBloc.add(NewObjektForVorlageEvent(vorlageEntity: widget.vorlageEntity, objektEntity: objekt));
                } else {
                  ObjektEntity objekt = ObjektEntity(
                      id: widget.objektEntity!.id, titel: _titelController.text, beschreibung: _beschreibungController.text, verantwortlicher: _verantwortlicherController.text, kommentar: null);
                  objektBloc.add(EditObjektFromVorlageEvent(vorlageEntity: widget.vorlageEntity, objektEntity: objekt));
                }
                context.push(kVorlageDetails);
              },
              child: const Text("Speichern")),
          const SizedBox(
            height: 30,
          ),
          if (widget.objektEntity != null)
            ElevatedButton(
                onPressed: () {
                  objektBloc.add(DeleteObjektFromVorlageEvent(vorlageEntity: widget.vorlageEntity, objektEntity: widget.objektEntity!));
                  context.push(kVorlageDetails);
                },
                child: const Text("Löschen"))
        ],
      ),
    );
  }
}
