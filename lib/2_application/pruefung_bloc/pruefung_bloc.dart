import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_domain/entities/pruefung_entity.dart';
import '../../3_domain/repositories/pruefung_repository.dart';

part 'pruefung_event.dart';

part 'pruefung_state.dart';

class PruefungBloc extends Bloc<PruefungEvent, PruefungState> {
  final PruefungRepository pruefungRepository;

  PruefungBloc({required this.pruefungRepository}) : super(PruefungInitialState()) {
    on<LoadPruefungenEvent>((event, emit) async {
      emit(PruefungLoadingState());
      try {
        final List<PruefungEntity> pruefungen = await pruefungRepository.getPruefungen();
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

    on<NewPruefungEvent>((event, emit) async {
      emit(PruefungLoadingState());
      try {
        await pruefungRepository.newPruefung(event.pruefungEntity);
        emit(PruefungDetailsLoadedState(pruefungEntity: event.pruefungEntity));
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });

    on<DeletePruefungEvent>((event, emit) async {
      emit(PruefungLoadingState());
      try {
        final PruefungEntity pruefungEntity = event.pruefungEntity;
        await pruefungRepository.deletePruefung(pruefungEntity);
        emit(PruefungInitialState());
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });

    on<EditPruefungEvent>((event, emit) async {
      emit(PruefungLoadingState());
      try {
        final PruefungEntity pruefungEntity = event.pruefungEntity;
        await pruefungRepository.editPruefung(pruefungEntity);
        emit(PruefungDetailsLoadedState(pruefungEntity: pruefungEntity));
      } catch (e) {
        emit(PruefungErrorState(errorMessage: e.toString()));
      }
    });
  }
}
