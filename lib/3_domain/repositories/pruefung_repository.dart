import 'package:checkapp/3_domain/entities/pruefung_entity.dart';


abstract class PruefungRepository {
  List<PruefungEntity> getPruefungen();
  void newPruefung(PruefungEntity pruefung);
  void editPruefung(PruefungEntity pruefung);
  void deletePruefung(PruefungEntity pruefung);
}