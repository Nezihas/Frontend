import 'package:flutter/material.dart';
import 'package:temp_project/screens/superviseur_update_screen.dart'; // Add this line

import '../models/superviseur.dart';
import '../services/api_service.dart';
import 'superviseur_add_screen.dart'; // Add this line
import 'superviseur_detail_screen.dart'; // Add this line

class SuperviseurListScreen extends StatefulWidget {
  @override
  _SuperviseurListScreenState createState() => _SuperviseurListScreenState();
}

class _SuperviseurListScreenState extends State<SuperviseurListScreen> {
  late Future<List<Superviseur>> futureSuperviseurs;

  @override
  void initState() {
    super.initState();
    futureSuperviseurs = ApiService().fetchSuperviseurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Superviseurs'),
      ),
      body: FutureBuilder<List<Superviseur>>(
        future: futureSuperviseurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No superviseurs found'));
          } else {
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  futureSuperviseurs = ApiService().fetchSuperviseurs();
                });
                return futureSuperviseurs;
              },
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final superviseur = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(superviseur.firstname[0]),
                    ),
                    title: Text('${superviseur.firstname} ${superviseur.lastname}'),
                    subtitle: Text(superviseur.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuperviseurUpdateScreen(superviseur: superviseur),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteSuperviseur(superviseur.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuperviseurDetailScreen(superviseur: superviseur),
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
            MaterialPageRoute(builder: (context) => SuperviseurAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteSuperviseur(int id) async {
    try {
      await ApiService().deleteSuperviseur(id);
      setState(() {
        futureSuperviseurs = ApiService().fetchSuperviseurs();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Superviseur deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete superviseur: $e')),
      );
    }
  }
}
