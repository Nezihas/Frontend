import 'package:flutter/material.dart';

import '../models/superviseur.dart';

class SuperviseurDetailScreen extends StatelessWidget {
  final Superviseur superviseur;

SuperviseurDetailScreen({required this.superviseur});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${superviseur.firstname} ${superviseur.lastname}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.badge, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('ID: ${superviseur.id}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('First Name: ${superviseur.firstname}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Last Name: ${superviseur.lastname}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Email: ${superviseur.email}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Telephone: ${superviseur.telephone}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.cake, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Date of Birth: ${superviseur.dateOfBirth.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Date of Hire: ${superviseur.dateOfHire.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.transgender, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Gender: ${superviseur.gender ?? "N/A"}'), // Handling null values
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
