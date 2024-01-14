import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'snackbar_event.dart';

part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(SnackbarInitial()) {
    on<ShowSnackbarEvent>((event, emit) {
      final snackBar = SnackBar(
        backgroundColor: Colors.pink[700],
        content: Text(event.message),
        duration: const Duration(seconds: 3),
      );
      emit(ShowSnackbarState(snackBar: snackBar));
    });
  }
}
