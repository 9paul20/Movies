import 'package:flutter/material.dart';
import 'package:practica2/screens/add_note_screen.dart';
import 'package:practica2/screens/detail_screen.dart';
import 'package:practica2/screens/favourite_screen.dart';
import 'package:practica2/screens/fruitapp_screen.dart';
import 'package:practica2/screens/notes_screen.dart';
import 'package:practica2/screens/popular_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/fruit': (BuildContext context) => FruitApp(),
    '/notes': (BuildContext context) => NotesScreen(),
    '/add': (BuildContext context) => AddNoteScreen(),
    '/movies': (BuildContext context) => PopularScreen(),
    '/detail': (BuildContext context) => DetailScreen(),
    '/favourites': (BuildContext context) => FavouriteScreen(),
  };
}
