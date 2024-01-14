import 'package:bloc/bloc.dart';
import 'package:checkapp/3_domain/entities/id.dart';
import 'package:checkapp/3_domain/entities/object_entity.dart';
import 'package:checkapp/3_domain/entities/vorlage_entity.dart';
import 'package:meta/meta.dart';

import '../../3_domain/repositories/vorlage_repository.dart';

part 'vorlage_event.dart';

part 'vorlage_state.dart';

class VorlageBloc extends Bloc<VorlageEvent, VorlageState> {
  final VorlageRepository vorlageRepository;

  VorlageBloc({required this.vorlageRepository}) : super(VorlageInitialState()) {
    on<LoadVorlagenEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        final List<VorlageEntity> vorlagen = vorlageRepository.getVorlagen();
        emit(VorlagenLoadedState(vorlagen: vorlagen));
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<InitNewVorlageEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        emit(VorlageDetailsLoadedState());
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<LoadVorlageEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        final VorlageEntity vorlage = event.vorlageEntity;
        emit(VorlageDetailsLoadedState(vorlage: vorlage));
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<NewVorlageEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        vorlageRepository.newVorlage(event.vorlageEntity);
        emit(VorlageInitialState());
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteVorlageEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        vorlageRepository.deleteVorlage(event.vorlageEntity);
        emit(VorlageInitialState());
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });

    on<EditVorlageEvent>((event, emit) {
      emit(VorlageLoadingState());
      try {
        final VorlageEntity vorlage = event.vorlageEntity;
        vorlageRepository.editVorlage(vorlage);
        emit(VorlageInitialState());
      } catch (e) {
        emit(VorlageErrorState(errorMessage: e.toString()));
      }
    });
  }
}
