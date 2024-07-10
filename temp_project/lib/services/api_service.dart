import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/employee.dart';
import '../models/horaires.dart';
import '../models/permission.dart'; // Assurez-vous d'utiliser le bon chemin
import '../models/superviseur.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8081/api/';

  // Employee methods
  Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse('${baseUrl}employees'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Employee> employees = body.map((dynamic item) => Employee.fromJson(item)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<void> addEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('${baseUrl}employees'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add employee');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    final response = await http.put(
      Uri.parse('${baseUrl}employees/${employee.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update employee');
    }
  }

  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}employees/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee');
    }
  }

  // Superviseur methods
  Future<List<Superviseur>> fetchSuperviseurs() async {
    final response = await http.get(Uri.parse('${baseUrl}superviseurs'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Superviseur> superviseurs = body.map((dynamic item) => Superviseur.fromJson(item)).toList();
      return superviseurs;
    } else {
      throw Exception('Failed to load superviseurs');
    }
  }

  Future<void> addSuperviseur(Superviseur superviseur) async {
    final response = await http.post(
      Uri.parse('${baseUrl}superviseurs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(superviseur.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add superviseur');
    }
  }

  Future<void> updateSuperviseur(Superviseur superviseur) async {
    final response = await http.put(
      Uri.parse('${baseUrl}superviseurs/${superviseur.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(superviseur.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update superviseur');
    }
  }

  Future<void> deleteSuperviseur(int id) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}superviseurs/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete superviseur');
    }
  }

  // Horaire methods
  Future<void> addHoraire(Horaire horaire) async {
    final response = await http.post(
      Uri.parse('${baseUrl}horaires'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(horaire.toJson()),
    );

    if (response.statusCode != 200) {
      print('Failed to add horaire: ${response.body}');
      throw Exception('Failed to add horaire: ${response.body}');
    }
  }

 // Permission methods
  Future<List<Permission>> fetchPermissions() async {
    final response = await http.get(Uri.parse('${baseUrl}permissions'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Permission> permissions = body.map((dynamic item) => Permission.fromJson(item)).toList();
      return permissions;
    } else {
      throw Exception('Failed to load permissions');
    }
  }

  Future<void> updatePermission(Permission permission) async {
    final response = await http.put(
      Uri.parse('${baseUrl}permissions/${permission.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(permission.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update permission');
    }
  }
}
