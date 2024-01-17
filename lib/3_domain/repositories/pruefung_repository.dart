import 'package:checkapp/3_domain/entities/pruefung_entity.dart';

abstract class PruefungRepository {
  Future<List<PruefungEntity>> getPruefungen();
  Future<void> newPruefung(PruefungEntity pruefung);
  Future<List<PruefungEntity>> editPruefung(PruefungEntity pruefung);
  Future<List<PruefungEntity>> deletePruefung(PruefungEntity pruefung);
  Future<void> exportToCSV(List<PruefungEntity> pruefungen);
}