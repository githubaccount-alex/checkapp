part of 'vorlage_bloc.dart';

@immutable
abstract class VorlageState {}

class VorlageInitialState extends VorlageState {}

// Vorlagen

class VorlagenLoadingState extends VorlageState {}

class VorlagenErrorState extends VorlageState {
  final String errorMessage;
  VorlagenErrorState({required this.errorMessage});
}

class VorlagenLoadedState extends VorlageState {
  final List<VorlageEntity> vorlagen;
  VorlagenLoadedState({required this.vorlagen});
}

// Vorlage Details

class VorlageDetailsLoadingState extends VorlageState {}

class VorlageDetailsErrorState extends VorlageState {
  final String errorMessage;
  VorlageDetailsErrorState({required this.errorMessage});
}

class VorlageDetailsLoadedState extends VorlageState {
  final VorlageEntity vorlageEntity;
  VorlageDetailsLoadedState({required this.vorlageEntity});
}

// Objekt from Vorlage

class ObjektFromVorlageLoadingState extends VorlageState {}

class ObjektFromVorlageErrorState extends VorlageState {
  final String errorMessage;
  ObjektFromVorlageErrorState({required this.errorMessage});
}

class ObjektFromVorlageLoadedState extends VorlageState {
  final VorlageEntity vorlageEntity;
  final ObjektEntity objektEntity;
  ObjektFromVorlageLoadedState({required this.vorlageEntity, required this.objektEntity});
}
