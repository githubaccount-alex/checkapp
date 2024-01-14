part of 'pruefung_bloc.dart';

@immutable
abstract class PruefungEvent {}

class LoadPruefungenEvent extends PruefungEvent {}

class DeletePruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  DeletePruefungEvent({required this.pruefungEntity});
}

class InitNewPruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  InitNewPruefungEvent({required this.pruefungEntity});
}

class SavePruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  SavePruefungEvent({required this.pruefungEntity});
}

