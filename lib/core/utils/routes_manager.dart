import 'package:flutter/material.dart';
import 'package:movie_app_with_clean_architecture/movies/presentation/screens/movie_screen.dart';
import '../../movies/presentation/screens/movie_details_screen.dart';
import '../../movies/presentation/screens/movie_popular_screen.dart';
import '../../movies/presentation/screens/movie_top_rated_screen..dart';
import 'strings_manager.dart';

class Routes {
  static const String movieRoute = "/";
  static const String movieDetailsRoute = "/movieDetails";
  static const String movieTopRatedRoute = "/movieTopRated";
  static const String moviePopularRoute = "/moviePopular";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.movieRoute:
        return MaterialPageRoute(builder: (_) => const MovieScreen());

      case Routes.movieDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(id: settings.arguments as int));

      case Routes.movieTopRatedRoute:
        return MaterialPageRoute(builder: (_) => const MovieTopRatedScreen());

      case Routes.moviePopularRoute:
        return MaterialPageRoute(builder: (_) => const MoviePopularScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
