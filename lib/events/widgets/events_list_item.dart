import 'package:flutter/material.dart';

import '../models/data.dart';

class EventsListItem extends StatelessWidget {
  const EventsListItem({required this.model, super.key});

  final Data model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${model.id}', style: textTheme.bodySmall),
        title: Text(model.title),
        isThreeLine: true,
        subtitle: Text(model.description),
        dense: true,
      ),
    );
  }
}
