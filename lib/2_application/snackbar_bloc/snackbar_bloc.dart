import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'snackbar_event.dart';

part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(SnackbarInitial()) {
    on<SendSnackbarEvent>((event, emit) {
      emit(ShowSnackbarState(message: event.message));
    });
  }
}