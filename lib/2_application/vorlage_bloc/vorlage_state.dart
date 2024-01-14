part of 'vorlage_bloc.dart';

@immutable
abstract class VorlageState {}

class VorlageInitialState extends VorlageState {}

class VorlageLoadingState extends VorlageState {}

class VorlagenLoadedState extends VorlageState {
  final List<VorlageEntity> vorlagen;
  VorlagenLoadedState({required this.vorlagen});
}

class VorlageDetailsLoadedState extends VorlageState {
  final VorlageEntity? vorlage;
  VorlageDetailsLoadedState({this.vorlage});
}

class VorlageErrorState extends VorlageState {
  final String errorMessage;
  VorlageErrorState({required this.errorMessage});
}




