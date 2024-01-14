part of 'objekt_bloc.dart';

@immutable
abstract class ObjektState {}

class ObjektInitialState extends ObjektState {}

class ObjektLoadingState extends ObjektState {}

class ObjektLoadedFromVorlageState extends ObjektState {
  final VorlageEntity vorlageEntity;
  final ObjektEntity? objektEntity;
  ObjektLoadedFromVorlageState({required this.vorlageEntity, this.objektEntity});
}

class ObjektErrorState extends ObjektState {
  final String errorMessage;
  ObjektErrorState({required this.errorMessage});
}