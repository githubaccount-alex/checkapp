import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_domain/entities/object_entity.dart';
import '../../3_domain/entities/vorlage_entity.dart';
import '../../3_domain/repositories/vorlage_repository.dart';

part 'objekt_event.dart';
part 'objekt_state.dart';

class ObjektBloc extends Bloc<ObjektEvent, ObjektState> {
  final VorlageRepository vorlageRepository;
  ObjektBloc({required this.vorlageRepository}) : super(ObjektInitialState()) {

    on<LoadObjektFromVorlageEvent>((event, emit) {
      emit(ObjektLoadingState());
      try {
        emit(ObjektLoadedFromVorlageState(vorlageEntity: event.vorlageEntity, objektEntity: event.objektEntity));
      } catch (e) {
        emit(ObjektErrorState(errorMessage: e.toString()));
      }
    });

    on<InitVorlageForNewObjectEvent>((event, emit) {
      emit(ObjektLoadingState());
      try {
        emit(ObjektLoadedFromVorlageState(vorlageEntity: event.vorlageEntity));
      } catch (e) {
        emit(ObjektErrorState(errorMessage: e.toString()));
      }
    });

    on<CreateNewObjektForVorlageEvent>((event, emit) {
      emit(ObjektLoadingState());
      try {
        final VorlageEntity vorlage = event.vorlageEntity;
        final ObjektEntity objekt = event.objektEntity;
        vorlageRepository.newObjektForVorlage(vorlage, objekt);
        emit(ObjektInitialState());
      } catch (e) {
        emit(ObjektErrorState(errorMessage: e.toString()));
      }
    });

    on<DeleteObjektFromVorlageEvent>((event, emit) {
      emit(ObjektLoadingState());
      try {
        final VorlageEntity vorlage = event.vorlageEntity;
        final ObjektEntity objekt = event.objektEntity;
        vorlageRepository.deleteObjektFromVorlage(vorlage, objekt);
        emit(ObjektInitialState());
      } catch (e) {
        emit(ObjektErrorState(errorMessage: e.toString()));
      }
    });

    on<EditObjektFromVorlageEvent>((event, emit) {
      emit(ObjektLoadingState());
      try {
        final VorlageEntity vorlage = event.vorlageEntity;
        final ObjektEntity objekt = event.objektEntity;
        vorlageRepository.editObjektFromVorlage(vorlage, objekt);
        emit(ObjektInitialState());
      } catch (e) {
        emit(ObjektErrorState(errorMessage: e.toString()));
      }
    });
  }
}
