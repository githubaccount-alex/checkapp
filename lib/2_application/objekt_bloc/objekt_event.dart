part of 'objekt_bloc.dart';

@immutable
abstract class ObjektEvent {}

class LoadObjektFromVorlageEvent extends ObjektEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  LoadObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class InitVorlageForNewObjectEvent extends ObjektEvent {
  final VorlageEntity vorlageEntity;
  InitVorlageForNewObjectEvent({required this.vorlageEntity});
}

class NewObjektForVorlageEvent extends ObjektEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  NewObjektForVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class DeleteObjektFromVorlageEvent extends ObjektEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  DeleteObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}

class EditObjektFromVorlageEvent extends ObjektEvent {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  EditObjektFromVorlageEvent({required this.vorlageEntity, required this.objektEntity});
}