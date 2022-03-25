import 'package:flutter/material.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Text(movie['title']),
    );
  }
}
