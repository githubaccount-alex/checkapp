import 'package:bloc/bloc.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:meta/meta.dart';

import '../../3_domain/entities/object_entity.dart';
import '../../3_domain/repositories/vorlage_repository.dart';

part 'vorlage_event.dart';

part 'vorlage_state.dart';

class VorlageBloc extends Bloc<VorlageEvent, VorlageState> {
  final VorlageRepository vorlageRepository;
  VorlageBloc({required this.vorlageRepository}) : super(VorlageInitialState()) {

    // Vorlagen

    on<LoadVorlagenEvent>((event, emit) async {
      emit(VorlagenLoadingState());
      try {
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();

          emit(VorlagenLoadedState(vorlagen: vorlagen));

      } catch (e) {
        emit(VorlagenErrorState(errorMessage: e.toString()));
      }
    });

    // Vorlage Details

    on<LoadVorlageDetailsEvent>((event, emit) async {
      emit(VorlageDetailsLoadingState());
      try {
        emit(VorlageDetailsLoadedState(vorlageEntity: event.vorlageEntity));
      } catch (e) {
        emit(VorlageDetailsErrorState(errorMessage: e.toString()));
      }
    });

    on<CreateNewVorlageDetailsEvent>((event, emit) async {
      emit(VorlageDetailsLoadingState());
      try {
        await vorlageRepository.newVorlage(event.vorlageEntity);
        emit(VorlageDetailsLoadedState(vorlageEntity: event.vorlageEntity));
      } catch (e) {
        emit(VorlageDetailsErrorState(errorMessage: e.toString()));
      }
    });

    on<EditVorlageDetailsEvent>((event, emit) async {
      emit(VorlageDetailsLoadingState());
      try {
      final List<VorlageEntity> vorlagen = await vorlageRepository.editVorlage(event.vorlageEntity);
        emit(VorlagenLoadedState(vorlagen: vorlagen));
      } catch (e) {
        emit(VorlageDetailsErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteVorlageDetailsEvent>((event, emit) async {
      emit(VorlageDetailsLoadingState());
      try {
        await vorlageRepository.deleteVorlage(event.vorlageEntity);
        final List<VorlageEntity> vorlagen = await vorlageRepository.getVorlagen();
        emit(VorlagenLoadedState(vorlagen: vorlagen));
      } catch (e) {
        emit(VorlageDetailsErrorState(errorMessage: e.toString()));
      }
    });

    // Objekte

    on<LoadObjektFromVorlageEvent>((event, emit) async {
      emit(ObjektFromVorlageLoadingState());
      try {
        emit(ObjektFromVorlageLoadedState(vorlageEntity: event.vorlageEntity, objektEntity: event.objektEntity));
      } catch (e) {
        emit(ObjektFromVorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<CreateNewObjektForVorlageEvent>((event, emit) async {
      emit(ObjektFromVorlageLoadingState());
      try {
        await vorlageRepository.newObjektForVorlage(event.vorlageEntity, event.objektEntity);
        emit(ObjektFromVorlageLoadedState(vorlageEntity: event.vorlageEntity, objektEntity: event.objektEntity));
      } catch (e) {
        emit(ObjektFromVorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<EditObjektFromVorlageEvent>((event, emit) async {
      emit(ObjektFromVorlageLoadingState());
      try {
        VorlageEntity vorlageEntity = await vorlageRepository.editObjektFromVorlage(event.vorlageEntity, event.objektEntity);
        emit(VorlageDetailsLoadedState(vorlageEntity: vorlageEntity));
      } catch (e) {
        emit(ObjektFromVorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteObjektFromVorlageEvent>((event, emit) async {
      emit(ObjektFromVorlageLoadingState());
      try {
        VorlageEntity vorlageEntity = await vorlageRepository.deleteObjektFromVorlage(event.vorlageEntity, event.objektEntity);
        emit(VorlageDetailsLoadedState(vorlageEntity: vorlageEntity));
      } catch (e) {
        emit(ObjektFromVorlageErrorState(errorMessage: e.toString()));
      }
    });

  }
}
