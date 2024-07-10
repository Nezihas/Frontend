import 'package:flutter/material.dart';

import '../models/horaires.dart';
import '../services/api_service.dart';
import 'horaire_update_screen.dart';
import 'horaires_detail_screen.dart';

class HoraireListScreen extends StatefulWidget {
  @override
  _HoraireListScreenState createState() => _HoraireListScreenState();
}

class _HoraireListScreenState extends State<HoraireListScreen> {
  late Future<List<Horaire>> futureHoraires;

  @override
  void initState() {
    super.initState();
    futureHoraires = ApiService().fetchHoraires();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horaires'),
      ),
      body: FutureBuilder<List<Horaire>>(
        future: futureHoraires,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No horaires found'));
          } else {
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  futureHoraires = ApiService().fetchHoraires();
                });
                return futureHoraires;
              },
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final horaire = snapshot.data![index];
                  return ListTile(
                    title: Text('Horaire ID: ${horaire.id}'),
                    subtitle: Text('${horaire.startTime} - ${horaire.endTime}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HoraireUpdateScreen(horaire: horaire),
                              ),
                            );
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.delete),
                        //   onPressed: () {
                        //     _deleteHoraire(horaire.id);
                        //   },
                        // ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HoraireDetailScreen(horaire: horaire),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => HoraireAddScreen()),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  // void _deleteHoraire(int id) async {
  //   try {
  //     await ApiService().deleteHoraire(id);
  //     setState(() {
  //       futureHoraires = ApiService().fetchHoraires();
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Horaire deleted successfully')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete horaire: $e')),
  //     );
  //   }
  // }
}
