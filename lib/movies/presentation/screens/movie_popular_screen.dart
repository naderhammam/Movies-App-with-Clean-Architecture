import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_clean_architecture/core/utils/color_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/constants_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/font_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/strings_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/values_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../controller/movie_bloc/movie_bloc.dart';

class MoviePopularScreen extends StatelessWidget {
  const MoviePopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        backgroundColor: AppColor.blueBlack,
        appBar: AppBar(
          title: const Text(
            AppStrings.popularMoviesAppbar,
            style: TextStyle(color: AppColor.white),
          ),
          backgroundColor: AppColor.blueBlack,
          centerTitle: true,
        ),
        body: const MoviesPopularItems(),
      ),
    );
  }
}

class MoviesPopularItems extends StatelessWidget {
  const MoviesPopularItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      switch (state.popularState) {
        case RequestState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case RequestState.loaded:
          return Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p14,
              right: AppPadding.p14,
            ),
            child: ListView.separated(
              itemCount: state.popularMovies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final movies = state.popularMovies[index];
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == AppConstants.cD0
                        ? AppPadding.p14
                        : AppPadding.p0,
                    bottom:
                        index == state.popularMovies.length - AppConstants.cI1
                            ? AppPadding.p20
                            : AppPadding.p0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetailsRoute,
                        arguments: movies.id,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.darkGrey,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: AppSize.s170,
                            width: AppSize.s120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: CachedNetworkImage(
                                imageUrl:
                                    ApiConstance.imageUrl(movies.backdropPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor:
                                      Colors.grey[AppConstants.colorValue850]!,
                                  highlightColor:
                                      Colors.grey[AppConstants.colorValue800]!,
                                  child: Container(
                                    height: AppSize.s170,
                                    width: AppSize.s120,
                                    decoration: BoxDecoration(
                                      color: AppColor.black,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: AppColor.white,
                                ),
                                height: AppSize.s170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies.title,
                                  maxLines: AppConstants.cI1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: AppSize.s16,
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s8,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: AppPadding.p2,
                                        horizontal: AppPadding.p8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s4),
                                      ),
                                      child: Text(
                                        movies.releaseDate
                                            .split('-')[AppConstants.cI0],
                                        style: const TextStyle(
                                          fontSize: AppFontSize.s12,
                                          fontWeight: AppFontWeight.medium,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSize.s16),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: AppColor.amber,
                                          size: AppSize.s20,
                                        ),
                                        const SizedBox(width: AppSize.s4),
                                        Text(
                                          (movies.voteAverage /
                                                  AppConstants.cI2)
                                              .toStringAsFixed(
                                                  AppConstants.cI1),
                                          style: const TextStyle(
                                            fontSize: AppFontSize.s12,
                                            fontWeight: AppFontWeight.medium,
                                            color: AppColor.white,
                                            letterSpacing: AppFontSize.s1_2,
                                          ),
                                        ),
                                        const SizedBox(width: AppSize.s4),
                                        Text(
                                          '(${movies.voteAverage})',
                                          style: const TextStyle(
                                            fontSize: AppFontSize.s1,
                                            fontWeight: AppFontWeight.medium,
                                            letterSpacing: AppFontSize.s1_2,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSize.s18,
                                ),
                                Text(
                                  movies.overview,
                                  maxLines: AppConstants.cI2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: AppSize.s14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s14,
              ),
            ),
          );
        case RequestState.error:
          return Center(
            child: Text(state.popularMessage),
          );
      }
    });
  }
}
