
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_domain/entities/pruefung_entity.dart';
import '../../3_domain/repositories/pruefung_repository.dart';

part 'pruefung_event.dart';
part 'pruefung_state.dart';

class PruefungBloc extends Bloc<PruefungEvent, PruefungState> {

  final PruefungRepository pruefungRepository;
  PruefungBloc({required this.pruefungRepository}) : super(PruefungInitialState()) {

    on<LoadPruefungenEvent>((event, emit) {
      emit(PruefungLoadingState());
      try {
        final List<PruefungEntity> pruefungen = pruefungRepository.getPruefungen();
        emit(PruefungenLoadedState(pruefungen: pruefungen));
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });

    on<InitNewPruefungEvent>((event, emit) {
      emit(PruefungLoadingState());
      try {
        emit(PruefungDetailsLoadedState());
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });

    on<SavePruefungEvent>((event, emit) {
      emit(PruefungLoadingState());
      try {
        final PruefungEntity pruefungEntity = event.pruefungEntity;
        pruefungRepository.newPruefung(pruefungEntity);
        emit(PruefungInitialState());
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });

    on<DeletePruefungEvent>((event, emit) {
      emit(PruefungLoadingState());
      try {
        final PruefungEntity pruefungEntity = event.pruefungEntity;
        pruefungRepository.deletePruefung(pruefungEntity);
        emit(PruefungInitialState());
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });



  }
}
