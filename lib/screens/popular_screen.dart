import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:practica2/models/popular_model.dart';
//import 'package:practica2/models/video_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:practica2/network/api_popular.dart';
import 'package:practica2/views/card_popular_view.dart';
import 'package:animations/animations.dart';
import 'dart:math' as math;

import '../constants.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  Api? api;
  List? l = [];
  String? idVideo;
  PageController? _pageController;
  int initialPage = 0;

  @override
  void initState() {
    super.initState();
    api = Api();
    _pageController = PageController(
      viewportFraction: 0.83,
      initialPage: initialPage,
    );
    print(initialPage);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body:
      Column(
        children: [
          SizedBox(height: kDefaultPadding),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: api!.getAllPopular(),
                /*future: Future.wait([
                  api!.getAllPopular(),
                  api!.getVideo(1),
                ]),*/
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
                }),
          ),
        ],
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
      child: PageView.builder(
          onPageChanged: (value){
            initialPage = value;
            /*setState(() {
              initialPage = value;
              print("Te cambio el valor $initialPage por $value");
            });*/
          },
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          itemCount: movies?.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController!,
              builder: (context, child) {
                double value = 0;
                if(_pageController!.position.haveDimensions){
                  value = index - _pageController!.page!;
                  value = (value *0.038).clamp(-1, 1);
                }
                PopularModel popular = movies![index];
                //var video = (api!.getVideo(popular.id!)).toString();
                var video = (api!.getVideo(popular.id!));
                //String l = await video;
                //print(index);
                //print(video);
                //video.then((v) {
                  //---
                  //print('https://www.youtube.com/watch?v=$v');
                  //print(popular.id!);
                  //print(popular.title!);
                  //l!.add(v); //---
                  //idVideo = '$v';
                //}); //---
                //var video = (api!.getVideo(popular.id!).then((value) => print(value)));
                //print(l![index]); //---
                //print(video.then((value) => print(value)));
                //print(idVideo);
                //print(api!.getVideo(popular.id!).then((value) => print(value)));
                /*if(idVideo == null) {
              idVideo = 'zdstyaz7ZlI';
            }*/

                /*return Transform.rotate(
                    angle: math.pi * value,
                    child: CardPopularView(
                      popularModel: popular,
                      //itemCount: movies.length,
                      //video: 'zdstyaz7ZlI',
                      //video: '${idVideo}',
                      //video: 'https://www.youtube.com/watch?v=${l![index]}', //---
                      //video: '${l![index]}', //---
                    )
                );*/

                return AnimatedOpacity(
                  duration: Duration(milliseconds: 350),
                  opacity: initialPage == index ? 1 : 0.4,
                  child: Transform.rotate(
                    angle: math.pi * value,
                    child: CardPopularView(
                      popularModel: popular,
                      //itemCount: movies.length,
                      //video: 'zdstyaz7ZlI',
                      //video: '${idVideo}',
                      //video: 'https://www.youtube.com/watch?v=${l![index]}', //---
                      //video: '${l![index]}', //---
                    )
                  ),
                );

                /*
                return CardPopularView(
                  popularModel: popular,
                  //itemCount: movies.length,
                  //video: 'zdstyaz7ZlI',
                  //video: '${idVideo}',
                  //video: 'https://www.youtube.com/watch?v=${l![index]}', //---
                  //video: '${l![index]}', //---
                );*/
              },
            );
          },
          /*separatorBuilder: (_, __) => const Divider(
                height: 10,
              ),
          //itemCount: movies!.length,
          itemCount: 1,*/
      ),
    );
  }
}
