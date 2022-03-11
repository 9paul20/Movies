import 'package:flutter/material.dart';
import 'package:practica2/screens/add_note_screen.dart';
import 'package:practica2/screens/fruitapp_screen.dart';
import 'package:practica2/screens/notes_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/fruit': (BuildContext context) => FruitApp(),
    '/notes': (BuildContext context) => NotesScreen(),
    '/add': (BuildContext context) => AddNoteScreen(),
  };
}
