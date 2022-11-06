import 'package:movie_app_with_clean_architecture/core/network/api_constance.dart';
import 'package:movie_app_with_clean_architecture/movies/domain/entities/movie_recommendations.dart';

class MovieRecommendationsModel extends MovieRecommendations {
  const MovieRecommendationsModel({super.backdropPath, required super.id});

  factory MovieRecommendationsModel.fromJson(Map<String, dynamic> json) {
    return MovieRecommendationsModel(
      backdropPath: json['backdrop_path'] ?? ApiConstance.whenNullImage,
      id: json['id'],
    );
  }
}
