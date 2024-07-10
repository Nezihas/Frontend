import 'package:flutter/material.dart';

import '../models/horaires.dart';
import '../services/api_service.dart';

class HoraireUpdateScreen extends StatefulWidget {
  final Horaire horaire;

  HoraireUpdateScreen({required this.horaire});

  @override
  _HoraireUpdateScreenState createState() => _HoraireUpdateScreenState();
}

class _HoraireUpdateScreenState extends State<HoraireUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _employeeIdController;
  late TextEditingController _commentaireController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _startTimeController = TextEditingController(text: widget.horaire.startTime.toIso8601String());
    _endTimeController = TextEditingController(text: widget.horaire.endTime.toIso8601String());
    _employeeIdController = TextEditingController(text: widget.horaire.employeeId.toString());
    _commentaireController = TextEditingController(text: widget.horaire.commentaire);
    _dateController = TextEditingController(text: widget.horaire.date.toIso8601String().split('T')[0]);
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _employeeIdController.dispose();
    _commentaireController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _updateHoraire() async {
    if (_formKey.currentState!.validate()) {
      Horaire updatedHoraire = Horaire(
        id: widget.horaire.id,
        startTime: DateTime.parse(_startTimeController.text),
        endTime: DateTime.parse(_endTimeController.text),
        employeeId: int.parse(_employeeIdController.text),
        commentaire: _commentaireController.text,
        date: DateTime.parse(_dateController.text),
      );

      try {
        await ApiService().updateHoraire(updatedHoraire);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Horaire updated successfully')),
        );
        Navigator.pop(context, updatedHoraire);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update horaire: $e')),
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
        title: Text('Update Horaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _startTimeController,
                decoration: InputDecoration(labelText: 'Start Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(labelText: 'End Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter end time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(labelText: 'Employee ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _commentaireController,
                decoration: InputDecoration(labelText: 'Commentaire'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter commentaire';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(context, _dateController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateHoraire,
                child: Text('Update Horaire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
