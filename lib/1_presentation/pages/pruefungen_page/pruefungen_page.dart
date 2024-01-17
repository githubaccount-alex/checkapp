import 'package:checkapp/1_presentation/pages/pruefungen_page/widgets/pruefung_details_body.dart';
import 'package:checkapp/1_presentation/pages/pruefungen_page/widgets/pruefungen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../common_widgets/error_message.dart';


class PruefungenPage extends StatelessWidget {
  const PruefungenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pruefungBloc = BlocProvider.of<PruefungBloc>(context)..add(LoadPruefungenEvent());

    return BlocBuilder<PruefungBloc, PruefungState>(
      bloc: pruefungBloc,
      builder: (context, state) {
        if (state is PruefungenLoadingState || state is PruefungDetailsLoadingState) {
          return Center(child: CircularProgressIndicator(color: Colors.pink.shade400));
        } else if (state is PruefungenErrorState) {
          return ErrorMessage(message: state.errorMessage);
        } else if (state is PruefungDetailsErrorState) {
          return ErrorMessage(message: state.errorMessage);
        } else if (state is VorlagenForPruefungEmptyState) {
          return const ErrorMessage(message: "Du musst zuerst eine Vorlage erstellen");
        } else if (state is PruefungenLoadedState) {
          return PruefungenBody(pruefungen: state.pruefungen, vorlagen: state.vorlagen);
        } else if (state is PruefungDetailsLoadedState) {
          return PruefungDetailsBody(pruefungEntity: state.pruefungEntity);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
