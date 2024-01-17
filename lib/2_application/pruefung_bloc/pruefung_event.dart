part of 'pruefung_bloc.dart';

@immutable
abstract class PruefungEvent {}

class LoadPruefungenEvent extends PruefungEvent {}

class LoadPruefungDetailsEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  LoadPruefungDetailsEvent({required this.pruefungEntity});
}

class CreateNewPruefungDetailsEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  CreateNewPruefungDetailsEvent({required this.pruefungEntity});
}

class EditPruefungDetailsEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  EditPruefungDetailsEvent({required this.pruefungEntity});
}

class DeletePruefungDetailsEvent extends PruefungEvent {
  final PruefungEntity pruefungEntity;
  DeletePruefungDetailsEvent({required this.pruefungEntity});
}

class NoVorlagenForPruefungEvent extends PruefungEvent {}

class ExportPruefungenToCsv extends PruefungEvent {}
