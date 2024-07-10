import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../models/superviseur.dart';
import '../services/api_service.dart';

class SuperviseurUpdateScreen extends StatefulWidget {
  final Superviseur superviseur;

  SuperviseurUpdateScreen({required this.superviseur});

  @override
  _SuperviseurUpdateScreenState createState() => _SuperviseurUpdateScreenState();
}

class _SuperviseurUpdateScreenState extends State<SuperviseurUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  late TextEditingController _telephoneController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _dateOfHireController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.superviseur.firstname);
    _lastnameController = TextEditingController(text: widget.superviseur.lastname);
    _emailController = TextEditingController(text: widget.superviseur.email);
    _telephoneController = TextEditingController(text: widget.superviseur.telephone);
    _dateOfBirthController = TextEditingController(text: widget.superviseur.dateOfBirth.toIso8601String().split('T')[0]);
    _dateOfHireController = TextEditingController(text: widget.superviseur.dateOfHire.toIso8601String().split('T')[0]);
    _selectedGender = widget.superviseur.gender ?? 'female'; // Set initial gender value with a fallback
  }

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

  void _updateSuperviseur() async {
    if (_formKey.currentState!.validate()) {
      Superviseur updatedSuperviseur = Superviseur(
        id: widget.superviseur.id,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        email: _emailController.text,
        telephone: _telephoneController.text,
        dateOfBirth: DateTime.parse(_dateOfBirthController.text),
        dateOfHire: DateTime.parse(_dateOfHireController.text),
        gender: _selectedGender,
      );

      try {
        await ApiService().updateSuperviseur(updatedSuperviseur);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Superviseur updated successfully')),
        );
        Navigator.pop(context, updatedSuperviseur);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update superviseur: $e')),
        );
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
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Superviseur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    return 'Please enter telephone number';
                  } else if (!RegExp(r'^\d{8}$').hasMatch(value)) {
                    return 'Please enter a valid 8-digit telephone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
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
                decoration: InputDecoration(labelText: 'Date of Hire'),
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
                onPressed: _updateSuperviseur,
                child: Text('Update Superviseur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
