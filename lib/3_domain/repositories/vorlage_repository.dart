import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

import '../entities/object_entity.dart';

abstract class VorlageRepository {
  Future<List<VorlageEntity>> loadVorlagen();
  Future<void> newVorlage(VorlageEntity vorlage);
  Future<void> editVorlage(VorlageEntity vorlage);
  Future<void> deleteVorlage(VorlageEntity vorlage);

  Future<List<ObjektEntity>> getObjekteFromVorlage(VorlageEntity vorlage);
  Future<void> newObjektForVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  Future<void> editObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  Future<void> deleteObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);
}