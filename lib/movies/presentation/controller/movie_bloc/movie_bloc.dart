import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_now_playing_movies_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_popular_movies_usecase.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/use_cases/get_top_rated_movies_usecase.dart';
import '../../../../core/utils/enums_manager.dart';
import '../../../domain/entities/movie.dart';
part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MovieBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }
  static MovieBloc get(context) => BlocProvider.of(context);

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getNowPlayingMoviesUseCase();
    result.fold(
      (l) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          nowPlayingState: RequestState.loaded,
          nowPlayingMovies: r,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getPopularMoviesUseCase();
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: l.message,
        ),
      ),
      (r) => emit(state.copyWith(
        popularMovies: r,
        popularState: RequestState.loaded,
      )),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getTopRatedMoviesUseCase();
    result.fold(
      (l) => emit(state.copyWith(
        topRatedState: RequestState.error,
        topRatedMessage: l.message,
      )),
      (r) => emit(state.copyWith(
        topRatedMovies: r,
        topRatedState: RequestState.loaded,
      )),
    );
  }
}
