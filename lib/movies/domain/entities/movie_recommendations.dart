import 'package:equatable/equatable.dart';

class MovieRecommendations extends Equatable {
  const MovieRecommendations({
    this.backdropPath,
    required this.id,
  });

  final String? backdropPath;
  final int id;

  @override
  List<Object?> get props => [backdropPath, id];
}
