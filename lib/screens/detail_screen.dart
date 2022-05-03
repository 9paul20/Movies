import 'package:flutter/material.dart';
import 'package:practica2/models/popular_model.dart';
import 'package:practica2/network/api_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:practica2/models/actor_model.dart';

import '../constants.dart';
import '../database/database_movies.dart';
import '../models/actor_model.dart';
import '../views/card_popular_view.dart';

class DetailScreen extends StatefulWidget {
  //const DetailScreen({Key? key, this.idMovie}) : super(key: key);
  const DetailScreen({Key? key}) : super(key: key);
  //final int? idMovie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //PopularModel? popularModel;
  String? urlMovie;
  Api? api;
  bool isFavorite = false;
  PopularModel? popular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api = Api();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //print(video);
    //idMovie = movie['id'];
    //print(idMovie);
    //print(movie['key']);
    /*print(
        'https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=5019e68de7bc112f4e4337a500b96c56');*/

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                height: size.height *0.4,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.4,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.4 - 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                BorderRadius.only(bottomLeft: Radius.circular(50)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${movie['url_image']}')
                              ),
                            )
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: size.width * 0.9,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topLeft: Radius.circular(50),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 50,
                                    color: Color(0xFF12153D).withOpacity(0.2),
                                  ),
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: kDefaultPadding / 1.5),
                                      Icon(Icons.star, color: Colors.yellow[400], size: 30),
                                      //Text("\n"),
                                      SizedBox(width: kDefaultPadding / 4),
                                      Expanded(
                                        flex: 1,
                                        child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: '${movie['vote_average']}/',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(text: "10\n"),
                                                TextSpan(
                                                  text: "${movie['vote_count']}",
                                                  style: TextStyle(color: kTextLightColor),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                    FutureBuilder(
                                        future: DatabaseMovies.isFavourite(movie['id']),
                                        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                                          if(snapshot.hasError) {
                                            return const Text("Error de Favoritos");
                                          }
                                          else{
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              isFavorite = snapshot.data!;
                                              popular = movie['map'];
                                              return Material(
                                                color: Colors.transparent,
                                                child: IconButton(
                                                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
                                                    iconSize: 40,
                                                    color: Colors.yellow[400],
                                                    onPressed: () {
                                                      if(!isFavorite) {
                                                        DatabaseMovies.insertar(popular!.toMap());
                                                      }
                                                      else {
                                                        DatabaseMovies.delete(movie['id']);
                                                      }
                                                      setState(() {
                                                        isFavorite = !isFavorite;
                                                      });
                                                    }
                                                ),
                                              );
                                            }
                                            else {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                          }
                                        }
                                    ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF51CF66),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Text(
                                          '${movie['popularity']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: kDefaultPadding / 4),
                                      Text("Metascore", style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                      Text("For Critic Reviews", style: TextStyle(color: kTextLightColor),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                            ),
                          ),
                          SafeArea(child: BackButton()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      movie['title'],
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                        children: <Widget>[
                                          Text(
                                            '${movie['release_date']}',
                                            style: TextStyle(color: kTextLightColor),
                                          ),
                                          SizedBox(width: kDefaultPadding / 2),
                                          Text(
                                            '${movie['original_language']}',
                                            style: TextStyle(color: kTextLightColor),
                                          ),
                                        ]
                                    ),
                                  ]
                              ),
                            ),
                          ]
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding,
                        ),
                        child: Text(
                          'Resumen',
                          style: Theme.of(context).textTheme.headline5,
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:kDefaultPadding),
                      child: Text(
                        movie['overview'],
                        style: TextStyle(
                          color: Color(0xFF737599),
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding,
                        ),
                        child: Text(
                          'Cast',
                          style: Theme.of(context).textTheme.headline5,
                        )
                    ),
                    FutureBuilder(
                      future: api!.getActors(movie['id']),
                      builder: (BuildContext context,
                      AsyncSnapshot<List<ActorModel>?> snapshot) {
                        List<ActorModel>? listTheActors = snapshot.data;
                        if(snapshot.hasError) {
                          return const Text("Error de Favoritos");
                        }
                        else{
                          if (snapshot.connectionState == ConnectionState.done) {
                            return SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  ActorModel actorModel = listTheActors![index];
                                  return Container(
                                    margin: EdgeInsets.only(right: kDefaultPadding),
                                    width: 80,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage('https://image.tmdb.org/t/p/w500/${actorModel.profile_path}'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: kDefaultPadding / 2),
                                        Text(
                                          '${actorModel.original_name}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyText2,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: kDefaultPadding / 4),
                                        Text(
                                          '${actorModel.character}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyText2,
                                          maxLines: 1,
                                        ),
                                      ]
                                    ),
                                  );
                                },
                                itemCount: listTheActors!.length,
                              ),
                            );
                          }else{
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                      }
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding,
                        ),
                        child: Text(
                          'Trailer',
                          style: Theme.of(context).textTheme.headline5,
                        )
                    ),
                    FutureBuilder(
                      future: api?.getVideo(movie['id']),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: size.height * 0.4 - 50,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50)),
                            ),
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data!,
                                flags: const YoutubePlayerFlags(
                                  hideControls: false,
                                  controlsVisibleAtStart: true,
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blue,
                            ),
                          );
                        }
                        else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ]
              ),
            ]
          ),
        ),
      ),
    );

    /*return Scaffold(
      appBar: AppBar(
        title: Text("${movie['title']}"),
        actions: <Widget>[
          FutureBuilder(
            future: DatabaseMovies.isFavourite(movie['id']),
            builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
              if(snapshot.hasError) {
                return const Text("Error de Favoritos");
              }
              else{
                if (snapshot.connectionState == ConnectionState.done) {
                  isFavorite = snapshot.data!;
                  popular = movie['map'];
                  //print("Agrega ESTO: ${popular!.backdropPath}");
                  return IconButton(
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        if(!isFavorite) {
                          DatabaseMovies.insertar(popular!.toMap());
                        }
                        else {
                          DatabaseMovies.delete(movie['id']);
                        }
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      }
                  );
                }
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            }
          ),
        ]
      ),
      body: FutureBuilder(
        builder: (
            BuildContext context,
            AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrio un error en la solicitud'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: FutureBuilder(
                      future: api?.getVideo(movie['id']),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: snapshot.data!,
                            flags: const YoutubePlayerFlags(
                              hideControls: false,
                              controlsVisibleAtStart: true,
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blue,
                        );
                      }
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('\n${movie['overview']}'),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: FutureBuilder(
                        future: api!.getActors(movie['id']),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ActorModel>?> snapshot) {
                          //print('Data de Snap: ${snapshot.data}');
                          if(snapshot.hasError){
                            return Text('Error en el actoraje');
                          }
                          else {
                            if(snapshot.connectionState == ConnectionState.done){
                              List<ActorModel>? listTheActors = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    ActorModel actorModel = listTheActors![index];
                                    //print(actorModel.name);
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.lightBlue,
                                          backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w500/${actorModel.profile_path}'),
                                          radius: 20,
                                        ),
                                        Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                '${actorModel.name} (${actorModel.character})',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13
                                                ),
                                              ),
                                            )
                                        ),
                                      ],
                                    );
                                    /*return Row(
                                  children:[
                                    Text('AJJAs'),
                                  ]
                                );*/
                                  },
                                  separatorBuilder: (_, __) => const Divider(
                                    height: 10,
                                  ),
                                  itemCount: listTheActors!.length,
                                ),
                              );
                            }
                            else{
                              return const Center(child: CircularProgressIndicator());
                            }
                          }
                        },
                      ),
                )),
              ],
            );
          }
        },
      ),
    );*/
  }
}
