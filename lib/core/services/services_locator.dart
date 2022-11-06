import 'package:get_it/get_it.dart';
import 'package:movie_app_with_clean_architecture/movies/data/data_sources/movie_remote_datasource.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/repositories/base_movie_repository.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_now_playing_movies_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_popular_movies_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_recommendations_movie_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_top_rated_movies_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/presentation/controller/movie_bloc/movie_bloc.dart';
import 'package:movie_app_with_clean_architecture/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import '../../movies/data/repositories/movie_repository.dart';
import '../../movies/domain/use_cases/get_details_movie_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// BLOC
    sl.registerFactory(() => MovieBloc(sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));

    /// USE CASES
    sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetDetailsMovieUseCase(sl()));
    sl.registerLazySingleton(() => GetRecommendationsMovieUseCase(sl()));

    /// REPOSITORY
    sl.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
  }
}
