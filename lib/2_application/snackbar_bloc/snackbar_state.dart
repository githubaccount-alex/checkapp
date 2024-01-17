part of 'snackbar_bloc.dart';

@immutable
abstract class SnackbarState {}

class SnackbarInitial extends SnackbarState {}

class ShowSnackbarState extends SnackbarState {
  final String message;
  ShowSnackbarState({required this.message});
}
