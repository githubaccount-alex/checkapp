part of 'pruefung_bloc.dart';

@immutable
abstract class PruefungEvent {}

class LoadPruefungenEvent extends PruefungEvent {}

class InitNewPruefungEvent extends PruefungEvent {}

class NewPruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  NewPruefungEvent({required this.pruefungEntity});
}

class DeletePruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  DeletePruefungEvent({required this.pruefungEntity});
}

class EditPruefungEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  EditPruefungEvent({required this.pruefungEntity});
}

