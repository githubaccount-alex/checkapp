part of 'pruefung_bloc.dart';

@immutable
abstract class PruefungState {}

class PruefungInitialState extends PruefungState {}

// Prüfungen

class PruefungenLoadingState extends PruefungState {}

class PruefungenErrorState extends PruefungState {
  final String errorMessage;
  PruefungenErrorState({required this.errorMessage});
}

class PruefungenLoadedState extends PruefungState {
  final List<PruefungEntity> pruefungen;
  final List<VorlageEntity> vorlagen;
  PruefungenLoadedState({required this.pruefungen, required this.vorlagen});
}

// Prüfungen Details

class PruefungDetailsLoadingState extends PruefungState {}

class VorlagenForPruefungEmptyState extends PruefungState {}

class PruefungDetailsErrorState extends PruefungState {
  final String errorMessage;
  PruefungDetailsErrorState({required this.errorMessage});
}

class PruefungDetailsLoadedState extends PruefungState {
  final PruefungEntity pruefungEntity;
  PruefungDetailsLoadedState({required this.pruefungEntity});
}
