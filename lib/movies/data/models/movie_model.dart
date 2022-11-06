import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.backdropPath,
      required super.genreIds,
      required super.id,
      required super.overview,
      required super.title,
      required super.voteAverage,
      required super.releaseDate});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'].cast<int>(),
      id: json['id'],
      overview: json['overview'],
      title: json['title'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
