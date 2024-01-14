import 'package:checkapp/3_domain/entities/id.dart';

import 'object_entity.dart';

class VorlageEntity {
  UniqueID id;
  String titel;
  String ort;
  String ort_detail;
  List<ObjektEntity> objekte;

  VorlageEntity({
    required this.id,
    required this.titel,
    required this.ort,
    required this.ort_detail,
    required this.objekte,
  });


}