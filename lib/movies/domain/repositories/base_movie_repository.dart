import 'package:dartz/dartz.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie.dart';
import '../../../core/error/failure.dart';
import '../entities/movie_detail.dart';
import '../entities/movie_recommendations.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getDetailsMovie(int movieId);

  Future<Either<Failure, List<MovieRecommendations>>> getRecommendationsMovie(
      int movieId);
}
