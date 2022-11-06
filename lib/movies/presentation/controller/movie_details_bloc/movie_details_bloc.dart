import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie_detail.dart';
import '../../../../core/utils/enums_manager.dart';
import '../../../domain/entities/movie_recommendations.dart';
import '../../../domain/use_cases/get_details_movie_usecase.dart';
import '../../../domain/use_cases/get_recommendations_movie_usecase.dart';
part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetDetailsMovieUseCase getDetailsMovieUseCase;
  final GetRecommendationsMovieUseCase getRecommendationsMovieUseCase;

  MovieDetailsBloc(
    this.getRecommendationsMovieUseCase,
    this.getDetailsMovieUseCase,
  ) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getRecommendationsMovie);
  }

  MovieDetailsBloc get(context) => BlocProvider.of(context);

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await getDetailsMovieUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          movieDetailsState: RequestState.error,
          messageMovieDetails: failure.message,
        ),
      ),
      (movieDetail) => emit(
        state.copyWith(
          movieDetailsState: RequestState.loaded,
          movieDetail: movieDetail,
        ),
      ),
    );
  }

  FutureOr<void> _getRecommendationsMovie(GetMovieRecommendationEvent event,
      Emitter<MovieDetailsState> emit) async {
    final result = await getRecommendationsMovieUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          movieRecommendationsState: RequestState.error,
          messageMovieRecommendations: failure.message,
        ),
      ),
      (movieRecommendations) => emit(
        state.copyWith(
          movieRecommendationsState: RequestState.loaded,
          movieRecommendations: movieRecommendations,
        ),
      ),
    );
  }
}
