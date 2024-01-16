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


  // Convert ObjektEntity to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(), // Convert UniqueID to String
      'titel': titel,
      'beschreibung': beschreibung,
      'verantwortlicher': verantwortlicher,
      'kommentar': kommentar,
    };
  }

  // Create ObjektEntity from a Map
  factory ObjektEntity.fromJson(Map<String, dynamic> json) {
    return ObjektEntity(
      id: UniqueID.fromString(json['id'] ?? ''), // Provide a default value or handle accordingly
      titel: json['titel'] ?? '',
      beschreibung: json['beschreibung'] ?? '',
      verantwortlicher: json['verantwortlicher'] ?? '',
      kommentar: json['kommentar'] ?? null, // Use null if 'kommentar' is not present
    );
  }
}