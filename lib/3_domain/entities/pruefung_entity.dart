import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

class PruefungEntity {
  UniqueID id;
  String? pruefer;
  DateTime datum;
  VorlageEntity vorlage;

  PruefungEntity({
    required this.id,
    this.pruefer,
    required this.datum,
    required this.vorlage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'pruefer': pruefer,
      'datum': datum.toIso8601String(),
      'vorlage': vorlage.toJson(),
    };
  }


  factory PruefungEntity.fromJson(Map<String, dynamic> json) {
    return PruefungEntity(
      id: UniqueID.fromString(json['id'] ?? ''),
      pruefer: json['pruefer'] ?? '',
      datum: DateTime.tryParse(json['datum'] ?? '') ?? DateTime.now(),
      vorlage: VorlageEntity.fromJson(json['vorlage'] ?? {}),
    );
  }
}