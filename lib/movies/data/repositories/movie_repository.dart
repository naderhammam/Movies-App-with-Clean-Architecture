import 'package:dartz/dartz.dart';
import 'package:movie_app_with_clean_architecture/core/error/exceptions.dart';
import 'package:movie_app_with_clean_architecture/core/error/failure.dart';
import 'package:movie_app_with_clean_architecture/movies/data/data_sources/movie_remote_datasource.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie_detail.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie_recommendations.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/base_movie_repository.dart';

class MovieRepository implements BaseMovieRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MovieRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await baseMovieRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getDetailsMovie(int movieId) async {
    final result = await baseMovieRemoteDataSource.getDetailsMovie(movieId);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MovieRecommendations>>> getRecommendationsMovie(
      int movieId) async {
    final result =
        await baseMovieRemoteDataSource.getRecommendationsMovie(movieId);
    try {
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }
}
