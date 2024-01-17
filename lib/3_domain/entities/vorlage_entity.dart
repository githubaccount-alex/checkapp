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

  // Convert VorlageEntity to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(), // Convert UniqueID to String
      'titel': titel,
      'ort': ort,
      'ort_detail': ort_detail,
      'objekte': objekte.map((objekt) => objekt.toJson()).toList(),
    };
  }

  // Create VorlageEntity from a Map
  factory VorlageEntity.fromJson(Map<String, dynamic> json) {
    return VorlageEntity(
      id: UniqueID.fromString(json['id'] ?? ''), // Provide a default value or handle accordingly
      titel: json['titel'] ?? '',
      ort: json['ort'] ?? '',
      ort_detail: json['ort_detail'] ?? '',
      objekte: (json['objekte'] as List<dynamic>?)
          ?.map((objektJson) => ObjektEntity.fromJson(objektJson))
          .toList() ?? [],
    );
  }

//
}