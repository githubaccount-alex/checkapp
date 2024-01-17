part of 'vorlage_bloc.dart';

@immutable
abstract class VorlageEvent {}

// Vorlagen

class LoadVorlagenEvent extends VorlageEvent {}

// Vorlage Details

class LoadVorlageDetailsEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  LoadVorlageDetailsEvent({required this.vorlageEntity});
}

class CreateNewVorlageDetailsEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  CreateNewVorlageDetailsEvent({required this.vorlageEntity});
}

class EditVorlageDetailsEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  EditVorlageDetailsEvent({required this.vorlageEntity});
}

class DeleteVorlageDetailsEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  DeleteVorlageDetailsEvent({required this.vorlageEntity});
}

// Objekte

class LoadObjektFromVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  LoadObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class CreateNewObjektForVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  CreateNewObjektForVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class EditObjektFromVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  EditObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class DeleteObjektFromVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  DeleteObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}
