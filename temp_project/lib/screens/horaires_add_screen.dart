import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/horaires.dart';
import '../services/api_service.dart';

class HoraireAddScreen extends StatefulWidget {
  final int employeeId;

  HoraireAddScreen({required this.employeeId});

  @override
  _HoraireAddScreenState createState() => _HoraireAddScreenState();
}

class _HoraireAddScreenState extends State<HoraireAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _commentaireController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _commentaireController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      controller.text = DateFormat('HH:mm').format(selectedTime);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _addHoraire() async {
  if (_formKey.currentState!.validate()) {
    Horaire newHoraire = Horaire(
      id: 0,
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      employeeId: widget.employeeId,
      commentaire: _commentaireController.text,
      date: DateTime.parse(_dateController.text),
    );

    try {
      await ApiService().addHoraire(newHoraire);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Horaire added successfully')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add horaire: $e')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Horaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _startTimeController,
                decoration: InputDecoration(labelText: 'Start Time (HH:mm)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectTime(context, _startTimeController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(labelText: 'End Time (HH:mm)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectTime(context, _endTimeController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter end time';
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
                decoration: InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(context);
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
                onPressed: _addHoraire,
                child: Text('Add Horaire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
