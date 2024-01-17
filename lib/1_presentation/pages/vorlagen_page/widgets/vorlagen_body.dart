import 'package:checkapp/1_presentation/common_widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../2_application/vorlage_bloc/vorlage_bloc.dart';
import '../../../../3_domain/entities/id.dart';
import '../../../../3_domain/entities/vorlage_entity.dart';
import '../../../routes/paths.dart';

class VorlagenBody extends StatelessWidget {
  final List<VorlageEntity> vorlagen;

  const VorlagenBody({super.key, required this.vorlagen});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VorlageBloc>(context);

    Widget? getVorlagenList(List<VorlageEntity> vorlagen) {
      if (vorlagen.isNotEmpty) {
        return ListView.builder(
          itemCount: vorlagen.length,
          prototypeItem: ListTile(
            title: Text(vorlagen.first.titel),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(vorlagen[index].titel),
              subtitle: Text(vorlagen[index].ort),
              onTap: () {
                bloc.add(LoadVorlageDetailsEvent(vorlageEntity: vorlagen[index]));
              },
            );
          },
        );
      } else {
        return null;
      }
    }

    return MainWidget(
      showAppbar: true,
      bottomNavbarIndex: 2,
      appbarTitle: "Vorlagen",
      leadingWidget: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.push(kDashboard);
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          VorlageEntity emptyVorlage = VorlageEntity(id: UniqueID(), titel: "", ort: "", ort_detail: "", objekte: []);
          bloc.add(CreateNewVorlageDetailsEvent(vorlageEntity: emptyVorlage));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: getVorlagenList(vorlagen) ?? const SizedBox(),
    );
  }
}
