import 'package:flutter/material.dart';

import '../models/horaires.dart';

class HoraireDetailScreen extends StatelessWidget {
  final Horaire horaire;

  HoraireDetailScreen({required this.horaire});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horaire Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${horaire.id}'),
            Text('Start Time: ${horaire.startTime}'),
            Text('End Time: ${horaire.endTime}'),
            Text('Employee ID: ${horaire.employeeId}'),
            Text('Commentaire: ${horaire.commentaire}'),
            Text('Date: ${horaire.date}'),
          ],
        ),
      ),
    );
  }
}
