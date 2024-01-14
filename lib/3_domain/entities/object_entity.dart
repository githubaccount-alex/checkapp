import 'package:checkapp/3_domain/entities/id.dart';

class ObjektEntity {
  UniqueID id;
  String titel;
  String beschreibung;
  String verantwortlicher;
  String? kommentar;

  ObjektEntity({
    required this.id,
    required this.titel,
    required this.beschreibung,
    required this.verantwortlicher,
    required this.kommentar,
  });
}