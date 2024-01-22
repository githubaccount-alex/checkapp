import 'dart:convert';
import 'dart:typed_data';

import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

class PruefungEntity {
  UniqueID id;
  String? pruefer;
  DateTime datum;
  VorlageEntity vorlage;
  List<Uint8List?> imageData = [];

  PruefungEntity({
    required this.id,
    this.pruefer,
    required this.datum,
    required this.vorlage,
    required this.imageData,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'pruefer': pruefer,
      'datum': datum.toIso8601String(),
      'vorlage': vorlage.toJson(),
      'imageData': imageData.map((data) => data != null ? base64Encode(data) : null).toList(),
    };
  }

  factory PruefungEntity.fromJson(Map<String, dynamic> json) {
    return PruefungEntity(
      id: UniqueID.fromString(json['id'] ?? ''),
      pruefer: json['pruefer'] ?? '',
      datum: DateTime.tryParse(json['datum'] ?? '') ?? DateTime.now(),
      vorlage: VorlageEntity.fromJson(json['vorlage'] ?? {}),
      imageData: _fromJsonToImageData(json['imageData']),
    );
  }

  static List<Uint8List?> _fromJsonToImageData(dynamic jsonData) {
    if (jsonData is List) {
      return jsonData.map((encodedData) => encodedData != null ? base64Decode(encodedData) : null).toList();
    } else {
      return [];
    }
  }
}
