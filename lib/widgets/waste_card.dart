import 'package:flutter/material.dart';

import '../models/waste_item.dart';

class WasteCard extends StatelessWidget {
  const WasteCard({required this.item, super.key});

  final WasteItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.recycling)),
        title: Text(item.name),
        subtitle: Text('${item.category} · ${item.disposalTip}'),
        trailing: item.confidence == 0
            ? null
            : Text('${(item.confidence * 100).round()}%'),
      ),
    );
  }
}
