part of 'snackbar_bloc.dart';

@immutable
abstract class SnackbarEvent {}

class ShowSnackbarEvent extends SnackbarEvent {
  final String message;
  ShowSnackbarEvent({required this.message});
}
