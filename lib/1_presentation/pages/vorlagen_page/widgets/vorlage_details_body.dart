import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/object_entity.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../2_application/vorlage_bloc/vorlage_bloc.dart';
import '../../../common_widgets/main_widget.dart';
import '../../../routes/paths.dart';

class VorlageDetailsBody extends StatefulWidget {
  final VorlageEntity vorlageEntity;

  const VorlageDetailsBody({super.key, required this.vorlageEntity});

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
    _titelController.text = widget.vorlageEntity.titel ?? '';
    _ortController.text = widget.vorlageEntity.ort ?? '';
    _ortDetailController.text = widget.vorlageEntity.ort_detail ?? '';
  }

  _addObject() {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    final ObjektEntity emptyObject = ObjektEntity(id: UniqueID(), titel: "", beschreibung: "", verantwortlicher: "", kommentar: "IO");
    vorlageBloc.add(CreateNewObjektForVorlageEvent(vorlageEntity: widget.vorlageEntity, objektEntity: emptyObject));
  }

  _editObject(index) {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    final ObjektEntity objektEntity = widget.vorlageEntity.objekte[index];
    vorlageBloc.add(LoadObjektFromVorlageEvent(vorlageEntity: widget.vorlageEntity, objektEntity: objektEntity));
  }

  _saveVorlage() {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    final VorlageEntity vorlageEntity = VorlageEntity(id: widget.vorlageEntity.id, titel: _titelController.text, ort: _ortController.text, ort_detail: _ortDetailController.text, objekte: widget.vorlageEntity.objekte);
    vorlageBloc.add(EditVorlageDetailsEvent(vorlageEntity: vorlageEntity));
  }

  _deleteVorlage() {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);
    vorlageBloc.add(DeleteVorlageDetailsEvent(vorlageEntity: widget.vorlageEntity));
  }

  @override
  Widget build(BuildContext context) {
    return MainWidget(
      showAppbar: true,
      bottomNavbarIndex: 2,
      appbarTitle: "Vorlage: ${widget.vorlageEntity.titel}",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "btn1",
          onPressed: () {
            _addObject();
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("Objekt hinzufügen")),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _titelController,
              decoration: const InputDecoration(
                labelText: 'Titel',
              ),
            ),
            TextField(
              controller: _ortController,
              decoration: const InputDecoration(
                labelText: 'Ort',
              ),
            ),
            TextField(
              controller: _ortDetailController,
              decoration: const InputDecoration(
                labelText: 'Ort Details',
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _saveVorlage();
                    },
                    child: const Text("Speichern")),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      _deleteVorlage();
                    },
                    child: const Text("Löschen"))
              ],
            ),
            const Divider(),
            if (widget.vorlageEntity.objekte.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: widget.vorlageEntity.objekte.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.vorlageEntity.objekte[index].titel),
                      subtitle: Text(widget.vorlageEntity.objekte[index].verantwortlicher),
                      onTap: () {
                        _editObject(index);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
