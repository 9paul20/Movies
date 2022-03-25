import 'package:flutter/material.dart';
import 'package:practica2/models/popular_model.dart';

class CardPopularView extends StatelessWidget {
  CardPopularView({Key? key, this.popularModel}) : super(key: key);

  PopularModel? popularModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 5.0),
                blurRadius: 2.5)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popularModel!.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 500),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      popularModel!.title!,
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: {'title': popularModel!.title});
                        },
                        icon: Icon(
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
    );
  }
}
