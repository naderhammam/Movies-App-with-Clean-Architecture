import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final String backdropPath;
  final List<Genres> genres;
  final int id;
  final String overview;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;

  const MovieDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [
        backdropPath,
        genres,
        id,
        overview,
        releaseDate,
        runtime,
        title,
        voteAverage,
      ];
}

class Genres extends Equatable {
  final int id;
  final String name;

  const Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        id: json['id'],
        name: json['name'],
      );

  @override
  List<Object> get props => [id, name];
}
