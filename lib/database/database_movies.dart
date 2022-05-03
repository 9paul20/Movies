import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/models/popular_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseMovies {
  static const _nombreBD = 'MoviesDB';
  static const _versionBD = 1;

  static Database? _database;
  static Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  static _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);
    return await openDatabase(
      rutaBD,
      version: _versionBD,
      onCreate: _crearTablas,
    );
  }

  static _crearTablas(Database db, int version) {
    db.execute(
        "CREATE TABLE f_movies ("
            "backdrop_path varchar(150),"
            "id integer primary key,"
            "original_language varchar(30),"
            "original_title varchar(50),"
            "overview varchar(500),"
            "popularity real,"
            "poster_path varchar(60),"
            "release_date varchar(15),"
            "title varchar(40),"
            "vote_average real,"
            "vote_count integer);"
    );
  }

  static void insertar(Map<String, dynamic> row) async {
    var dbConexion = await database;
    print("\nTabla a mandar: $row\n");
    dbConexion!.insert("f_movies", row);
  }

  static void delete(int idMovie) async {
    var dbConexion = await database;
    dbConexion!
        .delete("f_movies", where: "id = ?", whereArgs: [idMovie]);
  }

  static Future<List<PopularModel>?> getAllFavouriteMovies() async {
    var dbConexion = await database;
    var result = await dbConexion!.query("f_movies");
    var list = result.map((note) => PopularModel.fromMap(note)).toList();
    return list;
  }

  static Future<bool> isFavourite(int idMovie) async {
    var dbConnection = await database;
    int? c = Sqflite.firstIntValue(await dbConnection!.rawQuery('SELECT COUNT(*) FROM f_movies WHERE id = $idMovie'));
    if(c == 1) {
      return true;
    }
    else {
      return false;
    }
  }
}

