import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:checkapp/3_domain/repositories/pruefung_repository.dart';

class PruefungRepositoryImplementation implements PruefungRepository {

  List<PruefungEntity> pruefungen = [];

  @override
  void deletePruefung(PruefungEntity pruefung) {
    pruefungen.remove(pruefung);
  }

  @override
  void editPruefung(PruefungEntity pruefung) {
    for (int i = 0; i < pruefungen.length; i++) {
      if (pruefungen[i].id == pruefung.id) {
        pruefungen[i] = pruefung;
        break;
      }
    }
  }

  @override
  List<PruefungEntity> getPruefungen() {
    return pruefungen;
  }

  @override
  void newPruefung(PruefungEntity pruefung) {
    pruefungen.add(pruefung);
  }




}