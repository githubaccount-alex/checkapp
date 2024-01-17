import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_domain/entities/pruefung_entity.dart';
import '../../3_domain/entities/vorlage_entity.dart';
import '../../3_domain/repositories/pruefung_repository.dart';
import '../../3_domain/repositories/vorlage_repository.dart';

part 'pruefung_event.dart';

part 'pruefung_state.dart';

class PruefungBloc extends Bloc<PruefungEvent, PruefungState> {
  final PruefungRepository pruefungRepository;
  final VorlageRepository vorlageRepository;

  PruefungBloc({required this.pruefungRepository, required this.vorlageRepository}) : super(PruefungInitialState()) {
    // Prüfungen

    on<LoadPruefungenEvent>((event, emit) async {
      emit(PruefungenLoadingState());
      try {
        final List<PruefungEntity> pruefungen = await pruefungRepository.getPruefungen();
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();

        emit(PruefungenLoadedState(pruefungen: pruefungen, vorlagen: vorlagen));
      } catch (e) {
        emit(PruefungenErrorState(errorMessage: e.toString()));
      }
    });

    // Prüfung Details

    on<NoVorlagenForPruefungEvent>((event, emit) async {
      emit(VorlagenForPruefungEmptyState());
    });

    on<LoadPruefungDetailsEvent>((event, emit) async {
      emit(PruefungDetailsLoadedState(pruefungEntity: event.pruefungEntity));
    });

    on<CreateNewPruefungDetailsEvent>((event, emit) async {
      emit(PruefungDetailsLoadingState());
      try {
        await pruefungRepository.newPruefung(event.pruefungEntity);
        emit(PruefungDetailsLoadedState(pruefungEntity: event.pruefungEntity));
      } catch (e) {
        emit(PruefungDetailsErrorState(errorMessage: e.toString()));
      }
    });

    on<EditPruefungDetailsEvent>((event, emit) async {
      emit(PruefungDetailsLoadingState());
      try {
        final List<PruefungEntity> pruefungen = await pruefungRepository.editPruefung(event.pruefungEntity);
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();
        emit(PruefungenLoadedState(pruefungen: pruefungen, vorlagen: vorlagen));
      } catch (e) {
        emit(PruefungDetailsErrorState(errorMessage: e.toString()));
      }
    });

    on<DeletePruefungDetailsEvent>((event, emit) async {
      emit(PruefungDetailsLoadingState());
      try {
        final List<PruefungEntity> pruefungen = await pruefungRepository.deletePruefung(event.pruefungEntity);
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();
        emit(PruefungenLoadedState(pruefungen: pruefungen, vorlagen: vorlagen));
      } catch (e) {
        emit(PruefungDetailsErrorState(errorMessage: e.toString()));
      }
    });

    // Export to CSV

    on<ExportPruefungenToCsv>((event, emit) async {
      emit(PruefungenLoadingState());
      try {
        final List<PruefungEntity> pruefungen = await pruefungRepository.getPruefungen();
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();
        await pruefungRepository.exportToCSV(pruefungen);
        emit(PruefungenLoadedState(pruefungen: pruefungen, vorlagen: vorlagen));
      } catch (e) {
        emit(PruefungDetailsErrorState(errorMessage: e.toString()));
      }
    });
  }
}
