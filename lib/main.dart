import 'package:checkapp/0_common/theme/theme.dart';
import 'package:checkapp/4_infrastructure/repository_implementation/pruefung_repository_implementation.dart';
import 'package:checkapp/4_infrastructure/repository_implementation/vorlage_repository_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '2_application/objekt_bloc/objekt_bloc.dart';
import '2_application/pruefung_bloc/pruefung_bloc.dart';
import '2_application/snackbar_bloc/snackbar_bloc.dart';
import '2_application/vorlage_bloc/vorlage_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';
import '0_common/theme/theme_provider.dart';
import '1_presentation/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  //await prefs.clear();
  await PruefungRepositoryImplementation().getPruefungen();
  await VorlageRepositoryImplementation().loadVorlagen();
  await di.init();
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = MyRoutes().router;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData materialLightTheme = CheckTheme.materialLightTheme;
    ThemeData materialDarkTheme = CheckTheme.materialDarkTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PruefungBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SnackbarBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<VorlageBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ObjektBloc>(),
        ),
      ],
      child: MaterialApp.router(
        theme: Provider.of<ThemeProvider>(context).themeData,
        routerConfig: _appRouter,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('de'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}