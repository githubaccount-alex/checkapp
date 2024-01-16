import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:checkapp/3_domain/repositories/pruefung_repository.dart';

class PruefungRepositoryImplementation implements PruefungRepository {
  static const String pruefungenKey = 'pruefungen';

  // Initialize pruefungen list
  List<PruefungEntity> pruefungen = [];

  // Constructor to load pruefungen from SharedPreferences
  PruefungRepositoryImplementation() {
    _loadPruefungen();
  }

  // Helper method to load pruefungen from SharedPreferences
  Future<void> _loadPruefungen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pruefungenString = prefs.getString(pruefungenKey);

    if (pruefungenString != null && pruefungenString.isNotEmpty) {
      List<dynamic> pruefungenList = json.decode(pruefungenString);
      pruefungen = pruefungenList.map((json) => PruefungEntity.fromJson(json)).toList();
    }
  }

  // Helper method to save pruefungen to SharedPreferences
  Future<void> _savePruefungen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pruefungenString = json.encode(pruefungen.map((pruefung) => pruefung.toJson()).toList());
    prefs.setString(pruefungenKey, pruefungenString);
  }

  @override
  Future<List<PruefungEntity>> getPruefungen() async {
    return pruefungen;
  }

  @override
  Future<void> newPruefung(PruefungEntity pruefung) async {
    pruefungen.add(pruefung);
    await _savePruefungen();
  }

  @override
  Future<void> deletePruefung(PruefungEntity pruefung) async {
    pruefungen.remove(pruefung);
    await _savePruefungen();
  }

  @override
  Future<void> editPruefung(PruefungEntity pruefung) async {
    for (int i = 0; i < pruefungen.length; i++) {
      if (pruefungen[i].id == pruefung.id) {
        pruefungen[i] = pruefung;
        break;
      }
    }
    await _savePruefungen();
  }
}
