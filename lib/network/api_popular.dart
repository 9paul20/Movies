import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/models/popular_model.dart';
import 'package:practica2/models/actor_model.dart';

String? key;

class Api {
  Future<List<PopularModel>?> getAllPopular() async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=6305741d9dfb543cc64ea6ebc289ebc7&language=es-MX&page=1');
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      return popular.map((m) => PopularModel.fromMap(m)).toList();
    } else {
      return null;
    }
  }

  Future<String?> getVideo(int id) async {
    //Future<List<VideoModel>?> getVideo(int id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/${id}/videos?api_key=6305741d9dfb543cc64ea6ebc289ebc7&language=en-US');
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var movieVideo = jsonDecode(response.body)['results'] as List;
      for (var element in movieVideo) {
        if (element['type'] == 'Trailer' && element['official'] == true) {
          key = element['key'];
          return key;
        }
        else {
          key = element['key'];
          return key;
        }
      }
    } else {
      return 'zdstyaz7ZlI';
    }
  }

  Future<List<ActorModel>?> getActors(int id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=6305741d9dfb543cc64ea6ebc289ebc7');
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var actor = jsonDecode(response.body)['cast'] as List;
      return actor.map((a) => ActorModel.fromMap(a)).toList();
    } else {
      return null;
    }
  }
}
