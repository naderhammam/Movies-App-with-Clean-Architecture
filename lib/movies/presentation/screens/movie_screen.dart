import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_with_clean_architecture/core/utils/constants_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/font_manager.dart';
import 'package:movie_app_with_clean_architecture/movies/presentation/components/playing_movie_component.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../core/utils/values_manager.dart';
import '../components/popular_movie_component.dart';
import '../components/top_rated_movie_component.dart';
import '../controller/movie_bloc/movie_bloc.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          key: const Key(AppConstants.keyScroll),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlayingMovieComponent(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  AppMargin.m16,
                  AppMargin.m12,
                  AppMargin.m4,
                  AppMargin.m10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.popular,
                      style: GoogleFonts.poppins(
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.medium,
                        color: AppColor.white,
                        letterSpacing: AppFontSize.s0_15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.moviePopularRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Row(
                          children: const [
                            Text(
                              AppStrings.seeMore,
                              style: TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                            SizedBox(
                              width: AppSize.s4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppSize.s16,
                              color: AppColor.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const PopularMovieComponent(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  AppMargin.m16,
                  AppMargin.m20,
                  AppMargin.m4,
                  AppMargin.m8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.topRated,
                      style: GoogleFonts.poppins(
                        fontSize: AppFontSize.s20,
                        fontWeight: AppFontWeight.medium,
                        color: AppColor.white,
                        letterSpacing: AppFontSize.s0_15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.movieTopRatedRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Row(
                          children: const [
                            Text(
                              AppStrings.seeMore,
                              style: TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                            SizedBox(
                              width: AppSize.s4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppSize.s16,
                              color: AppColor.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TopRatedMovieComponent(),
              const SizedBox(height: AppSize.s20),
            ],
          ),
        ),
      ),
    );
  }
}
