import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../repositories/base_movie_repository.dart';

class GetPopularMoviesUseCase {
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase(this.baseMovieRepository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await baseMovieRepository.getPopularMovies();
  }
}
