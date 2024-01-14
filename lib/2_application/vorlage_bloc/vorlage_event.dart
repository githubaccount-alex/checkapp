part of 'vorlage_bloc.dart';

@immutable
abstract class VorlageEvent {}

class LoadVorlagenEvent extends VorlageEvent {}

class LoadVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  LoadVorlageEvent({required this.vorlageEntity});
}

class InitNewVorlageEvent extends VorlageEvent {}

class EditVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  EditVorlageEvent({required this.vorlageEntity});
}

class NewVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  NewVorlageEvent({required this.vorlageEntity});
}

class DeleteVorlageEvent extends VorlageEvent {
  final VorlageEntity vorlageEntity;
  DeleteVorlageEvent({required this.vorlageEntity});
}



