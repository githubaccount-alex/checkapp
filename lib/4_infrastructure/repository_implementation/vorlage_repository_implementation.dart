import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checkapp/3_domain/entities/object_entity.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:checkapp/3_domain/repositories/vorlage_repository.dart';

class VorlageRepositoryImplementation implements VorlageRepository {
  static const String vorlagenKey = 'vorlagen';

  // Initialize vorlagen list
  List<VorlageEntity> vorlagen = [];

  // Constructor to load vorlagen from SharedPreferences
  VorlageRepositoryImplementation() {
    _loadVorlagen();
  }

  // Helper method to load vorlagen from SharedPreferences
  Future<void> _loadVorlagen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vorlagenString = prefs.getString(vorlagenKey);

    if (vorlagenString != null && vorlagenString.isNotEmpty) {
      List<dynamic> vorlagenList = json.decode(vorlagenString);
      vorlagen = vorlagenList.map((json) => VorlageEntity.fromJson(json)).toList();
    }
  }

  // Helper method to save vorlagen to SharedPreferences
  Future<void> _saveVorlagen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String vorlagenString = json.encode(vorlagen.map((vorlage) => vorlage.toJson()).toList());
    prefs.setString(vorlagenKey, vorlagenString);
  }

  @override
  Future<List<VorlageEntity>> getVorlagen() async {
    return vorlagen;
  }

  @override
  Future<void> newVorlage(VorlageEntity vorlage) async {
    vorlagen.add(vorlage);
    _saveVorlagen();
  }

  @override
  Future<List<VorlageEntity>> deleteVorlage(VorlageEntity vorlage) async {
    vorlagen.remove(vorlage);
    _saveVorlagen();
    return vorlagen;
  }

  @override
  Future<List<VorlageEntity>> editVorlage(VorlageEntity vorlage) async {
    for (int i = 0; i < vorlagen.length; i++) {
      if (vorlagen[i].id == vorlage.id) {
        vorlagen[i] = vorlage;
        break;
      }
    }
    _saveVorlagen();
    return vorlagen;
  }

  @override
  Future<List<ObjektEntity>> getObjekteFromVorlage(VorlageEntity vorlage) async {
    return vorlage.objekte;
  }

  @override
  Future<void> newObjektForVorlage(VorlageEntity vorlage, ObjektEntity objekt) async {
    vorlage.objekte.add(objekt);
    editVorlage(vorlage);
  }

  @override
  Future<VorlageEntity> deleteObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt) async {
    vorlage.objekte.remove(objekt);
    editVorlage(vorlage);
    return vorlage;
  }

  @override
  Future<VorlageEntity> editObjektFromVorlage(VorlageEntity vorlage, ObjektEntity objekt) async {
    for (int i = 0; i < vorlage.objekte.length; i++) {
      if (vorlage.objekte[i].id == objekt.id) {
        vorlage.objekte[i] = objekt;
        break;
      }
    }
    editVorlage(vorlage);
    return vorlage;
  }
}
