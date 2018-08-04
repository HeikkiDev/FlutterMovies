import 'package:flutter/material.dart';
import 'package:flutter_app_ejemplo1/models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  Movie movie;

  // In the constructor, require a Movie
  MovieDetailPage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${movie.title}"),
      ),
      body: getBody()
    );
  }

  getBody(){
    return new ListView(
      children: <Widget>[
        getPosterForMovie(movie),
        Container(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "${movie.overview}",
            softWrap: true,
          ),
        )
      ],
    );
  }

  getPosterForMovie(Movie movie){
    if(movie.overview.isEmpty){
      return Image.network(
        "http://image.tmdb.org/t/p/w185/${movie.poster_path}",
        fit: BoxFit.fitHeight,
      );
    }
    else{
      return Image.network(
        "http://image.tmdb.org/t/p/w185/${movie.poster_path}",
        height: 400.0,
        fit: BoxFit.cover,
      );

    }
  }

}