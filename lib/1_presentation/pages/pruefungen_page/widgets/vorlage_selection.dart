import 'package:flutter/material.dart';

import '../../../../3_domain/entities/vorlage_entity.dart';

class VorlageSelection extends StatelessWidget {
  final List<VorlageEntity> vorlagen;
  const VorlageSelection({super.key, required this.vorlagen});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Wähle eine Vorlage aus'),
      content: Column(
        children: vorlagen.map((item) {
          return ListTile(
            title: Text(item.titel),
            onTap: () {
              Navigator.of(context).pop(item);
            },
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen'),
        ),
      ],
    );
  }
}
