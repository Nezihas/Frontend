import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../models/permission.dart';
import '../services/api_service.dart';

class PermissionsListScreen extends StatefulWidget {
  @override
  _PermissionsListScreenState createState() => _PermissionsListScreenState();
}

class _PermissionsListScreenState extends State<PermissionsListScreen> {
  late Future<List<Permission>> futurePermissions;
  late Future<List<Employee>> futureEmployees;
  late Map<int, String> employeeNames;

  @override
  void initState() {
    super.initState();
    futurePermissions = ApiService().fetchPermissions();
    futureEmployees = ApiService().fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Permissions'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, employeeSnapshot) {
          if (employeeSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (employeeSnapshot.hasError) {
            return Center(child: Text('Error: ${employeeSnapshot.error}'));
          } else if (employeeSnapshot.hasData) {
            employeeNames = {
              for (var employee in employeeSnapshot.data!) employee.id: employee.firstname
            };

            return FutureBuilder<List<Permission>>(
              future: futurePermissions,
              builder: (context, permissionSnapshot) {
                if (permissionSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (permissionSnapshot.hasError) {
                  return Center(child: Text('Error: ${permissionSnapshot.error}'));
                } else if (permissionSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: permissionSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      Permission permission = permissionSnapshot.data![index];
                      String employeeName = employeeNames[permission.idemployee] ?? 'Unknown';

                      return ListTile(
                        title: Text(employeeName),
                        subtitle: Text(permission.commentaire),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () async {
                                setState(() {
                                  permission.statut = 'accepte';
                                });
                                await ApiService().updatePermission(permission);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () async {
                                setState(() {
                                  permission.statut = 'refuse';
                                });
                                await ApiService().updatePermission(permission);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No permissions found'));
                }
              },
            );
          } else {
            return Center(child: Text('No employees found'));
          }
        },
      ),
    );
  }
}
