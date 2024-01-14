import 'package:checkapp/1_presentation/pages/neue_pruefung_details_page/widgets/neue_pruefung_details_body.dart';
import 'package:checkapp/3_domain/entities/pruefung_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../2_application/pruefung_bloc/pruefung_bloc.dart';

class NeuePruefungDetailsPage extends StatelessWidget {
  const NeuePruefungDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pruefungBloc = BlocProvider.of<PruefungBloc>(context);


    // This method can be improved....
    PruefungEntity? checkIfPruefungExists() {
      if (pruefungBloc.state is PruefungDetailsLoadedState && (pruefungBloc.state as PruefungDetailsLoadedState).pruefungEntity != null) {
        return (pruefungBloc.state as PruefungDetailsLoadedState).pruefungEntity;
      } else {
        return null;
      }
    }

    return BlocBuilder<PruefungBloc, PruefungState>(
      builder: (context, state) {
        if (state is PruefungLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PruefungErrorState) {
          return ErrorWidget(state.errorMessage);
        } else if (state is PruefungDetailsLoadedState) {
          return NeuePruefungDetailsBody(pruefungEntity: checkIfPruefungExists());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
