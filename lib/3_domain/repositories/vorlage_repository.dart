import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

import '../entities/object_entity.dart';

abstract class VorlageRepository {
  Future<List<VorlageEntity>> getVorlagen();
  Future<void> newVorlage(VorlageEntity vorlage);
  Future<List<VorlageEntity>> editVorlage(VorlageEntity vorlage);
  Future<List<VorlageEntity>> deleteVorlage(VorlageEntity vorlage);

  Future<List<ObjektEntity>> getObjekteFromVorlage(VorlageEntity vorlage);
  Future<void> newObjektForVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  Future<VorlageEntity> editObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);
  Future<VorlageEntity> deleteObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt);


}