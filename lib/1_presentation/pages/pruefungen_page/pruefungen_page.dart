import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../2_application/pruefung_bloc/pruefung_bloc.dart';
import '../../../3_domain/entities/pruefung_entity.dart';
import '../../common_widgets/error_message.dart';
import '../../common_widgets/main_widget.dart';
import '../../routes/paths.dart';

class PruefungenPage extends StatelessWidget {
  const PruefungenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pruefungBloc = BlocProvider.of<PruefungBloc>(context)..add(LoadPruefungenEvent());

    void _goToDetails(PruefungEntity pruefungEntity) {
      pruefungBloc.add(EditPruefungEvent(pruefungEntity: pruefungEntity));
      context.push(kNeuePruefungDetails);
    }

    return MainWidget(
      appbarTitle: "Prüfungen",
      bottomNavbarIndex: 1,
      showAppbar: true,
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      child: BlocBuilder<PruefungBloc, PruefungState>(
        bloc: pruefungBloc,
        builder: (context, state) {
          if (state is PruefungLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PruefungErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is PruefungenLoadedState) {
            if (state.pruefungen.isEmpty) {
              return const Center(child: Text("Es gibt noch keine Prüfungen"));
            } else {
              return ListView.builder(
                  itemCount: state.pruefungen.length ?? 0,
                  itemBuilder: (context, index) {
                    PruefungEntity pruefungEntity = state.pruefungen[index];
                    return ListTile(
                      title: Text("${pruefungEntity.vorlage.ort}, ${pruefungEntity.vorlage.ort_detail}"),
                      subtitle: Text(DateFormat('dd.MM.yyyy HH:mm').format(pruefungEntity.datum)),
                      onTap: () {
                        _goToDetails(pruefungEntity);
                      },
                    );
                  });
            }
          }
          return Center(child: CircularProgressIndicator(color: Colors.pink.shade400,));
        },
      ),
    );
  }
}
