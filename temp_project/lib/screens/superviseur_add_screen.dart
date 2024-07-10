import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../models/superviseur.dart';
import '../services/api_service.dart';

class SuperviseurAddScreen extends StatefulWidget {
  @override
  _SuperviseurAddScreenState createState() => _SuperviseurAddScreenState();
}

class _SuperviseurAddScreenState extends State<SuperviseurAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _dateOfHireController = TextEditingController();
  String _selectedGender = 'male'; // Default value

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _dateOfBirthController.dispose();
    _dateOfHireController.dispose();
    super.dispose();
  }

  Future<void> _addSuperviseur() async {
    if (_formKey.currentState!.validate()) {
      final newSuperviseur = Superviseur(
        id: 0, // This will be set by the backend
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        email: _emailController.text,
        telephone: _telephoneController.text,
        dateOfBirth: DateTime.parse(_dateOfBirthController.text),
        dateOfHire: DateTime.parse(_dateOfHireController.text),
        gender: _selectedGender,
      );

      try {
        await ApiService().addSuperviseur(newSuperviseur);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Superviseur added successfully')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add Superviseur: $e'),
        ));
      }
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Superviseur'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(labelText: 'Telephone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter telephone';
                  } else if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                    return 'Please enter a valid 8-digit telephone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth (yyyy-MM-dd)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(context, _dateOfBirthController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of birth';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfHireController,
                decoration: InputDecoration(labelText: 'Date of Hire (yyyy-MM-dd)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(context, _dateOfHireController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of hire';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['female', 'male'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addSuperviseur,
                child: Text('Add Superviseur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
