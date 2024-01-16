import 'package:checkapp/3_domain/entities/pruefung_entity.dart';


abstract class PruefungRepository {
  Future<List<PruefungEntity>> getPruefungen();
  Future<void> newPruefung(PruefungEntity pruefung);
  Future<void> editPruefung(PruefungEntity pruefung);
  Future<void> deletePruefung(PruefungEntity pruefung);
}