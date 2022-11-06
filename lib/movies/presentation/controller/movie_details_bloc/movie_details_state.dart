part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final RequestState movieDetailsState;
  final String messageMovieDetails;
  final MovieDetail? movieDetail;

  final RequestState movieRecommendationsState;
  final String messageMovieRecommendations;
  final List<MovieRecommendations>? movieRecommendations;

  const MovieDetailsState({
    this.movieDetailsState = RequestState.loading,
    this.messageMovieDetails = '',
    this.movieDetail,
    this.movieRecommendationsState = RequestState.loading,
    this.messageMovieRecommendations = '',
    this.movieRecommendations,
  });

  MovieDetailsState copyWith({
    RequestState? movieDetailsState,
    String? messageMovieDetails,
    MovieDetail? movieDetail,
    RequestState? movieRecommendationsState,
    String? messageMovieRecommendations,
    List<MovieRecommendations>? movieRecommendations,
  }) {
    return MovieDetailsState(
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      messageMovieDetails: messageMovieDetails ?? this.messageMovieDetails,
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      messageMovieRecommendations:
          messageMovieRecommendations ?? this.messageMovieRecommendations,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
    );
  }

  @override
  List<Object?> get props => [
        movieDetailsState,
        messageMovieDetails,
        movieDetail,
        movieRecommendationsState,
        messageMovieRecommendations,
        movieRecommendations,
      ];
}
