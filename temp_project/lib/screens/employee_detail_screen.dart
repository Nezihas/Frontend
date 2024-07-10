import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  EmployeeDetailScreen({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${employee.firstname} ${employee.lastname}'),
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
                    Text('ID: ${employee.id}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('First Name: ${employee.firstname}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Last Name: ${employee.lastname}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Email: ${employee.email}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Telephone: ${employee.telephone}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.cake, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Date of Birth: ${employee.dateOfBirth.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Date of Hire: ${employee.dateOfHire.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.transgender, color: Colors.blueAccent),
                    SizedBox(width: 8.0),
                    Text('Gender: ${employee.gender ?? "N/A"}'), // Handling null values
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
