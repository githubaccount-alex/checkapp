import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/object_entity.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:checkapp/3_domain/repositories/vorlage_repository.dart';

class VorlageRepositoryImplementation implements VorlageRepository {
  List<VorlageEntity> vorlagen = [
    VorlageEntity(
        id: UniqueID(),
        titel: "Titel 1",
        ort: "Ort 1",
        ort_detail: "Ort Details 1",
        objekte: [ObjektEntity(id: UniqueID(), titel: "Objekt 1", beschreibung: 'Beschreibug 1', verantwortlicher: 'VBM', kommentar: 'IO')]),
  ];

  @override
  List<VorlageEntity> getVorlagen() {
    return vorlagen;
  }

  @override
  void newVorlage(VorlageEntity vorlage) {
    vorlagen.add(vorlage);
  }

  @override
  void deleteVorlage(VorlageEntity vorlage) {
    vorlagen.remove(vorlage);
  }

  @override
  void editVorlage(VorlageEntity vorlage) {
    for (int i = 0; i < vorlagen.length; i++) {
      if (vorlagen[i].id == vorlage.id) {
        vorlagen[i] = vorlage;
        break;
      }
    }
  }

  @override
  List<ObjektEntity> getObjekteFromVorlage(VorlageEntity vorlage) {
    return vorlage.objekte;
  }

  @override
  void newObjektForVorlage(VorlageEntity vorlage, ObjektEntity objekt) {
    vorlage.objekte.add(objekt);
    editVorlage(vorlage);
  }

  @override
  void deleteObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt) {
    vorlage.objekte.remove(objekt);
    editVorlage(vorlage);
  }

  @override
  void editObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt) {
    for (int i = 0; i < vorlage.objekte.length; i++) {
      if (vorlage.objekte[i].id == objekt.id) {
        vorlage.objekte[i] = objekt;
        break;
      }
    }
    editVorlage(vorlage);
  }
}
