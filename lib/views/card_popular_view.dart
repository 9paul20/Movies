import 'package:flutter/material.dart';
import 'package:practica2/models/popular_model.dart';
import 'package:animations/animations.dart';

import '../constants.dart';
//import 'package:practica2/models/video_model.dart';

class CardPopularView extends StatelessWidget {
  //CardPopularView({Key? key, this.popularModel, this.video}) : super(key: key);
  CardPopularView({Key? key, this.popularModel}) : super(key: key);

  PopularModel? popularModel;
  //String? video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: InkWell(
        onTap: () {
      Navigator.pushNamed(context, '/detail', arguments: {
        'title': popularModel!.title!,
        'url_image':
        'https://image.tmdb.org/t/p/w500/${popularModel!.backdrop_path!}',
        'overview': popularModel!.overview!,
        'id': popularModel!.id!,
        'vote_average': popularModel!.vote_average!,
        'vote_count': popularModel!.vote_count!,
        'popularity': popularModel!.popularity!,
        'original_language': popularModel!.original_language!,
        'release_date': popularModel!.release_date!,
        'map': popularModel!,
        });
      },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [kDefaultShadow],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${popularModel!.poster_path}',
                      ),
                    ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: Text(
                popularModel!.title!,
                style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star, color: Colors.yellow[400]),
                SizedBox(width: kDefaultPadding / 2),
                Text("${popularModel!.vote_average}", style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ]
        ),
      ),
    );

    /*return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: const [
        BoxShadow(
            color: Colors.black12, offset: Offset(0.0, 5.0), blurRadius: 2.5)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: FadeInImage(
                placeholder: const AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popularModel!.backdrop_path}'),
                fadeInDuration: Duration(milliseconds: 500),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                      popularModel!.title!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    ),
                    IconButton(
                        onPressed: () {
                          //print('Id de pelicula: ${popularModel!.id}');
                          //print('Id de Video: ${video!}');
                          //print('Key de Video: ${videoModel!.key}');
                          Navigator.pushNamed(context, '/detail', arguments: {
                            'title': popularModel!.title!,
                            'url_image':
                                'https://image.tmdb.org/t/p/w500/${popularModel!.backdrop_path!}',
                            'overview': popularModel!.overview!,
                            'id': popularModel!.id!,
                            'map': popularModel!,
                          });
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );*/
  }
}
