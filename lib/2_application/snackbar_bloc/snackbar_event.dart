part of 'snackbar_bloc.dart';

@immutable
abstract class SnackbarEvent {}

class SendSnackbarEvent extends SnackbarEvent {
  final String message;
  SendSnackbarEvent({required this.message});
}
