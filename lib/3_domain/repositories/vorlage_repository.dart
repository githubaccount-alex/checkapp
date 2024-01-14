import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

import '../entities/object_entity.dart';

abstract class VorlageRepository {
  List<VorlageEntity> getVorlagen();
  void newVorlage(VorlageEntity vorlage);
  void editVorlage(VorlageEntity vorlage);
  void deleteVorlage(VorlageEntity vorlage);

  List<ObjektEntity> getObjekteFromVorlage(VorlageEntity vorlage);
  void newObjektForVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  void editObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  void deleteObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);
}