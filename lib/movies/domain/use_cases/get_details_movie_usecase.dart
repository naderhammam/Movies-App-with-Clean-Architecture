import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/base_movie_repository.dart';

class GetDetailsMovieUseCase {
  final BaseMovieRepository baseMovieRepository;

  GetDetailsMovieUseCase(this.baseMovieRepository);

  Future<Either<Failure, MovieDetail>> call(int movieId) async {
    return await baseMovieRepository.getDetailsMovie(movieId);
  }
}
