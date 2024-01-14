import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../2_application/objekt_bloc/objekt_bloc.dart';
import '../../../../2_application/vorlage_bloc/vorlage_bloc.dart';
import '../../../routes/paths.dart';

class VorlageDetailsBody extends StatefulWidget {
  final VorlageEntity? vorlageEntity;

  const VorlageDetailsBody({super.key, this.vorlageEntity});

  @override
  State<VorlageDetailsBody> createState() => _VorlageDetailsBodyState();
}

class _VorlageDetailsBodyState extends State<VorlageDetailsBody> {
  final TextEditingController _titelController = TextEditingController();
  final TextEditingController _ortController = TextEditingController();
  final TextEditingController _ortDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titelController.text = widget.vorlageEntity?.titel ?? '';
    _ortController.text = widget.vorlageEntity?.ort ?? '';
    _ortDetailController.text = widget.vorlageEntity?.ort_detail ?? '';
  }

  void _saveVorlage() {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    String titel = _titelController.text;
    String ort = _ortController.text;
    String ortDetails = _ortDetailController.text;
    UniqueID id;
    if (widget.vorlageEntity != null) {
      id = widget.vorlageEntity!.id;
      VorlageEntity vorlageEntity = VorlageEntity(id: id, titel: titel, ort: ort, ort_detail: ortDetails, objekte: widget.vorlageEntity!.objekte);
      vorlageBloc.add(EditVorlageEvent(vorlageEntity: vorlageEntity));
    } else if (widget.vorlageEntity == null) {
      id = UniqueID();
      VorlageEntity vorlageEntity = VorlageEntity(id: id, titel: titel, ort: ort, ort_detail: ortDetails, objekte: []);
      vorlageBloc.add(NewVorlageEvent(vorlageEntity: vorlageEntity));
    }
    context.push(kVorlagen);
  }

  void _deleteVorlage() {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    vorlageBloc.add(DeleteVorlageEvent(vorlageEntity: widget.vorlageEntity!));
    context.push(kVorlagen);
  }

  void _addObject() {
    final objektBloc = BlocProvider.of<ObjektBloc>(context);
    objektBloc.add(InitVorlageForNewObjectEvent(vorlageEntity: widget.vorlageEntity!));
    context.push(kObjekt);
  }

  void _editObject(int index) {
    final objektBloc = BlocProvider.of<ObjektBloc>(context);
    objektBloc.add(LoadObjektFromVorlageEvent(vorlageEntity: widget.vorlageEntity!, objektEntity: widget.vorlageEntity!.objekte[index]));
    context.push(kObjekt);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              controller: _ortController,
              decoration: const InputDecoration(
                labelText: 'Ort',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _ortDetailController,
              decoration: const InputDecoration(
                labelText: 'Ort Details',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          if (widget.vorlageEntity != null && widget.vorlageEntity!.objekte.isNotEmpty)
            SizedBox(
              height: 130,
              child: ListView.builder(
                itemCount: widget.vorlageEntity!.objekte.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.vorlageEntity!.objekte[index].titel),
                    subtitle: Text(widget.vorlageEntity!.objekte[index].verantwortlicher),
                    onTap: () {
                      _editObject(index);
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                _addObject();
              },
              child: const Text("Objekt hinzufügen")),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                _saveVorlage();
              },
              child: const Text("Speichern")),
          const SizedBox(height: 10),
          if (widget.vorlageEntity != null)
            ElevatedButton(
                onPressed: () {
                  _deleteVorlage();
                },
                child: const Text("löschen"))
        ],
      ),
    );
  }
}
