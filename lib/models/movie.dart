class Movie {
  final String title;
  final String overview;
  final String poster_path;
  // + El resto de campos...

  Movie(this.title, this.overview, this.poster_path);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        json['title'],
        json['overview'],
        json['poster_path']
    );
  }
}