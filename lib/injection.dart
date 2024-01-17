import 'package:get_it/get_it.dart';

import '2_application/pruefung_bloc/pruefung_bloc.dart';
import '2_application/snackbar_bloc/snackbar_bloc.dart';
import '2_application/vorlage_bloc/vorlage_bloc.dart';
import '3_domain/repositories/pruefung_repository.dart';
import '3_domain/repositories/vorlage_repository.dart';
import '4_infrastructure/repository_implementation/pruefung_repository_implementation.dart';
import '4_infrastructure/repository_implementation/vorlage_repository_implementation.dart';

final sl = GetIt.I; // service Locator

Future<void> init() async {
  //? ################ Prüfung ##################
  // application layers
  sl.registerFactory(() => PruefungBloc(pruefungRepository: sl(), vorlageRepository: sl()));

  // repos
  sl.registerLazySingleton<PruefungRepository>(() => PruefungRepositoryImplementation());


  //? ################ Vorlage ##################
  // application layers
  sl.registerFactory(() => VorlageBloc(vorlageRepository: sl()));

  // repos
  sl.registerLazySingleton<VorlageRepository>(() => VorlageRepositoryImplementation());

  // ############## snackbar ##################
  sl.registerLazySingleton(() => SnackbarBloc());

}
