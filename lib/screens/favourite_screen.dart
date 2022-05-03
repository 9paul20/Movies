import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:animations/animations.dart';
import 'package:practica2/screens/popular_view_favourites.dart';

import '../database/database_movies.dart';
import '../models/popular_model.dart';
import '../views/card_popular_view.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites Movies'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child:
                //Text(''),
              FutureBuilder(
                  future: DatabaseMovies.getAllFavouriteMovies(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PopularModel>?> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Ocurrio un error en la solicitud'),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _listPopularMovies(
                          snapshot.data,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  }
                  ),
            ),
          ]
        ),


      bottomNavigationBar:
      Container(
        decoration: BoxDecoration(
          color:Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: "Inicio",
                  ),
                  GButton(
                    icon: LineIcons.heart,
                    text: "Favoritos",
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState((){
                    _selectedIndex = index;
                    if(_selectedIndex == 0){
                      Navigator.pushNamed(context, '/movies');
                    }
                    else{
                      Navigator.pushNamed(context, '/favourites');
                    }
                  });
                }
            ),
          ),
        ),
      ),
    );
  }

  Widget _listPopularMovies(List<PopularModel>? movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          PopularModel popular = movies![index];
          return CardPopularViewFavourite(
            popularModel: popular,
          );
        },
        separatorBuilder: (_, __) => const Divider(
          height: 10,
        ),
        itemCount: movies!.length,
      ),
    );
  }
}
