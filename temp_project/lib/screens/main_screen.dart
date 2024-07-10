import 'package:flutter/material.dart';
import 'package:temp_project/screens/login_employee_screen.dart';
import 'package:temp_project/screens/permission_list_screen.dart';

import 'employee_list_screen.dart';
import 'superviseur_list_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeListScreen()),
                );
              },
              child: Text('View Employees'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuperviseurListScreen()),
                );
              },
              child: Text('View Supervisors'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('ri7lett horaires'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PermissionsListScreen()),
                );
              },
              child: Text('ri7lett permissions'),
            ),
          ],
        ),
      ),
    );
  }
}
