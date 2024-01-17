import 'package:checkapp/1_presentation/pages/vorlagen_page/widgets/objekt_body.dart';
import 'package:checkapp/1_presentation/pages/vorlagen_page/widgets/vorlage_details_body.dart';
import 'package:checkapp/1_presentation/pages/vorlagen_page/widgets/vorlagen_body.dart';
import 'package:checkapp/2_application/vorlage_bloc/vorlage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../0_common/util/snackbar.dart';
import '../../../2_application/snackbar_bloc/snackbar_bloc.dart';
import '../../common_widgets/error_message.dart';

class VorlagenPage extends StatelessWidget {
  const VorlagenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VorlageBloc>(context)..add(LoadVorlagenEvent());
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackbarState) {
          final snackbar = SnackbarUtil();
          snackbar.showSnackBar(context, state.message);
        }
      },
      child: BlocBuilder<VorlageBloc, VorlageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is VorlagenLoadingState || state is VorlageDetailsLoadingState || state is ObjektFromVorlageLoadingState) {
            return Center(child: Center(child: CircularProgressIndicator(color: Colors.pink.shade400)));
          } else if (state is VorlagenErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is VorlageDetailsErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is ObjektFromVorlageErrorState) {
            return ErrorMessage(message: state.errorMessage);
          } else if (state is VorlagenLoadedState) {
            return VorlagenBody(vorlagen: state.vorlagen);
          } else if (state is VorlageDetailsLoadedState) {
            return VorlageDetailsBody(vorlageEntity: state.vorlageEntity);
          } else if (state is ObjektFromVorlageLoadedState) {
            return ObjektBody(vorlageEntity: state.vorlageEntity, objektEntity: state.objektEntity);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
