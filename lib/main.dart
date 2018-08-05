import 'package:flutter/material.dart';
import 'package:flutter_app_ejemplo1/detail.dart';
import 'package:flutter_app_ejemplo1/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //json
import 'dart:async'; // timer

void main() => runApp(new MyApp());

// App root class
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Movies Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent
      ),
      home: new MoviesPage()
    );
  }
}

// Home page class
class MoviesPage extends StatefulWidget {
  MoviesPage({Key key}) : super(key: key);

  @override
  _MoviesPageState createState() => new _MoviesPageState();
}

// Home page state class
class _MoviesPageState extends State<MoviesPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Movies"),
        ),
        body: getBody());
  }

  // Devuelve la lista rellena o un indicador de carga
  getBody() {
    if (movies.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return getListView();
    }
  }

  ListView getListView() => new ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  // Crea y devuelve un 'Label' con el título de la peli correspondiente
  Widget getRow(int i) {
    return new GestureDetector(
      child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Text("${movies[i].title}")
      ),
      onTap: () {
        // Abrir página de detalle de la película
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movies[i])
          )
        );
      }
    );
  }

  loadData() async {
    String dataURL = "https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2018-07-15&primary_release_date.lte=2018-07-22&language=es&api_key=29048abbc8184fde73f24020bf3cfff9";
    http.Response response = await http.get(dataURL);
    var responseJson = json.decode(response.body);
    // Simular carga de 5 segundos para que se muestre el loading indicator
    Timer timer = new Timer(new Duration(seconds: 2), () {
      setState(() {
        // Deserializa result (que es la lista de pelis) en una List de Movie
        movies =  (responseJson['results'] as List).map((p) => Movie.fromJson(p)).toList();
      });
    });
  }

}
