import 'package:flutter/material.dart';
import 'package:temp_project/screens/employee_update_screen.dart';

import '../models/employee.dart';
import '../services/api_service.dart';
import 'employee_add_screen.dart';
import 'employee_detail_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = ApiService().fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No employees found'));
          } else {
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  futureEmployees = ApiService().fetchEmployees();
                });
                return futureEmployees;
              },
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final employee = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(employee.firstname[0]),
                    ),
                    title: Text('${employee.firstname} ${employee.lastname}'),
                    subtitle: Text(employee.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeUpdateScreen(employee: employee),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteEmployee(employee.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetailScreen(employee: employee),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteEmployee(int id) async {
    try {
      await ApiService().deleteEmployee(id);
      setState(() {
        futureEmployees = ApiService().fetchEmployees();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete employee: $e')),
      );
    }
  }
}
