import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:checkapp/2_application/vorlage_bloc/vorlage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/error_message.dart';

class VorlagenPage extends StatelessWidget {
  const VorlagenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VorlageBloc>(context)..add(LoadVorlagenEvent());

    final theme = Theme.of(context);

    return MainWidget(
      showAppbar: true,
      bottomNavbarIndex: 3,
      appbarTitle: "Vorlagen",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: theme.primaryColor,
        onPressed: () {
          bloc.add(InitNewVorlageEvent());
          context.push(kVorlageDetails);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: BlocBuilder<VorlageBloc, VorlageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is VorlageInitialState) {
            bloc.add(LoadVorlagenEvent());
          } else if (state is VorlageLoadingState) {
            return const Center(child: Center(child: CircularProgressIndicator()));
          } else if (state is VorlageErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is VorlagenLoadedState) {
            if (state.vorlagen.isEmpty) {
              return const Center(child: Text("Es gibt noch keine Vorlagen"));
            } else {
              final items = state.vorlagen;
              return ListView.builder(
                itemCount: items.length,
                prototypeItem: ListTile(
                  title: Text(items.first.titel),
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].titel),
                    subtitle: Text(items[index].ort),
                    onTap: () {
                      bloc.add(LoadVorlageEvent(vorlageEntity: items[index]));
                      context.push(kVorlageDetails);
                    },
                  );
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator(color: Colors.pink.shade400,));
          },
      ),
    );
  }
}
