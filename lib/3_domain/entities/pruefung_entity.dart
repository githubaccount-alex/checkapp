import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';

class PruefungEntity {
  UniqueID id;
  String pruefer;
  DateTime datum;
  VorlageEntity vorlage;

  PruefungEntity({
    required this.id,
    required this.pruefer,
    required this.datum,
    required this.vorlage,
  });
}