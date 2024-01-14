part of 'pruefung_bloc.dart';

@immutable
abstract class PruefungState {}

class PruefungInitialState extends PruefungState {}

class PruefungLoadingState extends PruefungState {}

class PruefungenLoadedState extends PruefungState {
  final List<PruefungEntity> pruefungen;
  PruefungenLoadedState({required this.pruefungen});
}

class PruefungDetailsLoadedState extends PruefungState {
  final PruefungEntity? pruefungEntity;
  PruefungDetailsLoadedState({this.pruefungEntity});
}

class PruefungErrorState extends PruefungState {
  final String errorMessage;
  PruefungErrorState({required this.errorMessage});
}
