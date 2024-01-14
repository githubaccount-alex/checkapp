import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:checkapp/1_presentation/pages/objekt_page/widgets/objekt_body.dart';
import 'package:checkapp/1_presentation/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../2_application/objekt_bloc/objekt_bloc.dart';

class ObjektPage extends StatelessWidget {
  const ObjektPage({super.key});

  @override
  Widget build(BuildContext context) {
    final objektBloc = BlocProvider.of<ObjektBloc>(context);

    return MainWidget(
      showAppbar: true,
      appbarTitle: "Objekt",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kVorlageDetails);
        },
      ),
      child: BlocBuilder<ObjektBloc, ObjektState>(
        bloc: objektBloc,
        builder: (context, state) {
          if (state is ObjektLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ObjektErrorState) {
            return Center(child: ErrorWidget(state.errorMessage));
          } else if (state is ObjektLoadedFromVorlageState) {
            return ObjektBody(vorlageEntity: state.vorlageEntity, objektEntity: state.objektEntity);
          }
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        },
      ),
    );
  }
}
