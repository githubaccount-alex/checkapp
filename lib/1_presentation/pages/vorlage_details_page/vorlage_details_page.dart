import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/pages/vorlage_details_page/widgets/vorlage_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../2_application/vorlage_bloc/vorlage_bloc.dart';
import '../../../3_domain/entities/vorlage_entity.dart';
import '../../common_widgets/error_message.dart';
import '../../routes/paths.dart';

class VorlageDetailsPage extends StatelessWidget {
  const VorlageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vorlageBloc = BlocProvider.of<VorlageBloc>(context);

    String getAppbarTitle() {
      String appbarTitle = "Vorlage";
      if (vorlageBloc.state is VorlageDetailsLoadedState && (vorlageBloc.state as VorlageDetailsLoadedState).vorlage != null) {
        appbarTitle = (vorlageBloc.state as VorlageDetailsLoadedState).vorlage!.titel;
      }
      return appbarTitle;
    }

    // This method can be improved....
    VorlageEntity? checkIfVorlageExists() {
      if (vorlageBloc.state is VorlageDetailsLoadedState && (vorlageBloc.state as VorlageDetailsLoadedState).vorlage != null) {
        return (vorlageBloc.state as VorlageDetailsLoadedState).vorlage;
      } else {
        return null;
      }
    }

    return MainWidget(
      bottomNavbarIndex: 3,
      appbarTitle: getAppbarTitle(),
      showAppbar: true,
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kVorlagen);
        },
      ),
      child: BlocBuilder<VorlageBloc, VorlageState>(
        bloc: vorlageBloc,
        builder: (context, state) {
          if (state is VorlageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VorlageErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is VorlageDetailsLoadedState) {
            return VorlageDetailsBody(vorlageEntity: checkIfVorlageExists());
          }
          return Center(child: CircularProgressIndicator(color: Colors.pink.shade400,));
        },
      ),
    );
  }
}
