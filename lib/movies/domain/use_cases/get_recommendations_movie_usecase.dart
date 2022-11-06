import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie_recommendations.dart';
import '../repositories/base_movie_repository.dart';

class GetRecommendationsMovieUseCase {
  final BaseMovieRepository baseMovieRepository;

  GetRecommendationsMovieUseCase(this.baseMovieRepository);

  Future<Either<Failure, List<MovieRecommendations>>> call(int movieId) async {
    return await baseMovieRepository.getRecommendationsMovie(movieId);
  }
}
