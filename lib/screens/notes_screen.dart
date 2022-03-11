import 'package:flutter/material.dart';
import 'package:practica2/database/database_notas.dart';
import 'package:practica2/models/notes_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late DatabaseNotes dbNotes;

  @override
  void initState() {
    super.initState();
    dbNotes = DatabaseNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              icon: Icon(Icons.note_add))
        ],
      ),
      body: FutureBuilder(
          future: dbNotes.getAllNotes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NotesDAO>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Ocurrio un error al ejecutar :('));
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _listNotes(snapshot.data!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget _listNotes(List<NotesDAO> notes) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notes[index].titulo!),
        );
      },
      itemCount: notes.length,
    );
  }
}
