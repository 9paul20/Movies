import 'package:flutter/material.dart';
import 'package:practica2/models/popular_model.dart';
import 'package:practica2/network/api_popular.dart';
import 'package:practica2/views/card_popular_view.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrio un error en la solicitud'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _listPopularMovies(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget _listPopularMovies(List<PopularModel>? movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            PopularModel popular = movies![index];
            return CardPopularView(popularModel: popular);
          },
          separatorBuilder: (_, __) => Divider(
                height: 10,
              ),
          itemCount: movies!.length),
    );
  }
}
