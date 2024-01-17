import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:checkapp/3_domain/repositories/pruefung_repository.dart';

import '../../3_domain/entities/object_entity.dart';

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
  Future<List<PruefungEntity>> deletePruefung(PruefungEntity pruefung) async {
    pruefungen.remove(pruefung);
    await _savePruefungen();
    return pruefungen;
  }

  @override
  Future<List<PruefungEntity>> editPruefung(PruefungEntity pruefung) async {
    for (int i = 0; i < pruefungen.length; i++) {
      if (pruefungen[i].id == pruefung.id) {
        pruefungen[i] = pruefung;
        break;
      }
    }
    await _savePruefungen();
    return pruefungen;
  }

  @override
  Future<void> exportToCSV(List<PruefungEntity> pruefungen) async {
    try {
      List<List<dynamic>> csvData = [];

      csvData.add(['Pruefung ID', 'Pruefer', 'Datum', 'Vorlage Titel', 'Vorlage Ort', 'Vorlage Ort Detail', 'Objekt Titel', 'Objekt Beschreibung', 'Objekt Verantwortlicher', 'Objekt Kommentar']);

      int pruefungID = 0;

      for (PruefungEntity pruefung in pruefungen) {
        for (ObjektEntity objekt in pruefung.vorlage.objekte) {
          log(pruefung.id.value.toString());
          csvData.add([
            pruefungID.toString(),
            pruefung.pruefer ?? '',
            pruefung.datum.toIso8601String(),
            pruefung.vorlage.titel,
            pruefung.vorlage.ort,
            pruefung.vorlage.ort_detail,
            objekt.titel,
            objekt.beschreibung,
            objekt.verantwortlicher,
            objekt.kommentar,
          ]);

          pruefungID++;
        }
      }

      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      String csvFilePath = '${appDocumentsDir.path}/pruefungen.csv';

      File csvFile = File(csvFilePath);
      String csvContent = const ListToCsvConverter().convert(csvData);
      await csvFile.writeAsString(csvContent);
      log(csvContent);
      log(csvFilePath);
      log("Exported to CSV");
    } catch (e) {
      log('Error exporting CSV: $e');
    }
  }
}
