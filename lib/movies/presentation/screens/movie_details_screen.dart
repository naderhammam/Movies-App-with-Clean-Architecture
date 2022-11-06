import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_with_clean_architecture/core/utils/constants_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/font_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/routes_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/strings_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/values_manager.dart';
import 'package:movie_app_with_clean_architecture/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/enums_manager.dart';
import '../../domain/entities/movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationEvent(id)),
      child: const Scaffold(
        backgroundColor: AppColor.blueBlack,
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      switch (state.movieDetailsState) {
        case RequestState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case RequestState.loaded:
          return CustomScrollView(
            key: const Key(AppConstants.keyDetailsScroll),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: AppSize.s250,
                backgroundColor: AppColor.blueBlack,
                elevation: AppConstants.noElevation,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadeIn(
                    duration:
                        const Duration(milliseconds: AppConstants.fadeDelay),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.transparent,
                            AppColor.black,
                            AppColor.black,
                            AppColor.transparent,
                          ],
                          stops: [
                            AppConstants.cD0,
                            AppConstants.cD0_5,
                            AppConstants.cD1,
                            AppConstants.cD1,
                          ],
                        ).createShader(
                          Rect.fromLTRB(
                              AppSize.s0, AppSize.s0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: ApiConstance.imageUrl(
                            state.movieDetail!.backdropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FadeInUp(
                  from: AppConstants.fadeInFrom,
                  duration:
                      const Duration(milliseconds: AppConstants.fadeDelay),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.movieDetail!.title,
                            style: GoogleFonts.poppins(
                              fontSize: AppFontSize.s24,
                              fontWeight: AppFontWeight.bold,
                              color: AppColor.white,
                              letterSpacing: AppFontSize.s1_2,
                            )),
                        const SizedBox(height: AppSize.s8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p2,
                                horizontal: AppPadding.p8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[AppConstants.colorValue800],
                                borderRadius: BorderRadius.circular(AppSize.s4),
                              ),
                              child: Text(
                                state.movieDetail!.releaseDate
                                    .split('-')[AppConstants.cI0],
                                style: const TextStyle(
                                  fontSize: AppFontSize.s16,
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
                                  (state.movieDetail!.voteAverage /
                                          AppConstants.cI2)
                                      .toStringAsFixed(AppConstants.cI1),
                                  style: const TextStyle(
                                    fontSize: AppFontSize.s16,
                                    fontWeight: AppFontWeight.medium,
                                    color: AppColor.white,
                                    letterSpacing: AppFontSize.s1_2,
                                  ),
                                ),
                                const SizedBox(width: AppSize.s4),
                                Text(
                                  '(${state.movieDetail!.voteAverage})',
                                  style: const TextStyle(
                                    fontSize: AppFontSize.s1,
                                    fontWeight: AppFontWeight.medium,
                                    letterSpacing: AppFontSize.s1_2,
                                    color: AppColor.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: AppSize.s16),
                            Text(
                              _showDuration(state.movieDetail!.runtime),
                              style: const TextStyle(
                                color: AppColor.white70,
                                fontSize: AppFontSize.s16,
                                fontWeight: AppFontWeight.medium,
                                letterSpacing: AppFontSize.s1_2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s20),
                        Text(
                          state.movieDetail!.overview,
                          style: const TextStyle(
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.regular,
                            letterSpacing: AppFontSize.s1_2,
                            color: AppColor.white,
                          ),
                        ),
                        const SizedBox(height: AppSize.s8),
                        Text(
                          '${AppStrings.genres} ${_showGenres(state.movieDetail!.genres)}',
                          style: const TextStyle(
                            color: AppColor.white70,
                            fontSize: AppFontSize.s12,
                            fontWeight: AppFontWeight.medium,
                            letterSpacing: AppFontSize.s1_2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p24,
                ),
                sliver: SliverToBoxAdapter(
                  child: FadeInUp(
                    from: AppConstants.fadeInFrom,
                    duration:
                        const Duration(milliseconds: AppConstants.fadeDelay),
                    child: const Text(
                      AppStrings.moreLike,
                      style: TextStyle(
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.medium,
                        color: AppColor.white,
                        letterSpacing: AppFontSize.s1_2,
                      ),
                    ),
                  ),
                ),
              ),
              // Tab(text: 'More like this'.toUpperCase()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p24,
                ),
                sliver: _showRecommendations(),
              ),
            ],
          );
        case RequestState.error:
          return Center(
            child: Text(state.messageMovieDetails),
          );
      }
    });
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      switch (state.movieRecommendationsState) {
        case RequestState.loading:
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );

        case RequestState.loaded:
          if (state.movieRecommendations!.isEmpty) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Center(
                  child: FadeInUp(
                    from: AppConstants.fadeInFrom,
                    duration:
                        const Duration(milliseconds: AppConstants.fadeDelay),
                    child: const Text(
                      AppStrings.noRecommendations,
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                        fontWeight: AppFontWeight.semiBold,
                        color: AppColor.white,
                        letterSpacing: AppFontSize.s1_2,
                        height: AppFontSize.s1,
                      ),
                    ),
                  ),
                ),
                childCount: AppConstants.cI1,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppConstants.cI1,
                childAspectRatio: AppConstants.cD1_8,
              ),
            );
          }
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = state.movieRecommendations![index];
                return FadeInUp(
                  from: AppConstants.fadeInFrom,
                  duration:
                      const Duration(milliseconds: AppConstants.fadeDelay),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.movieDetailsRoute,
                          arguments: recommendation.id,
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiConstance.imageUrl(recommendation.backdropPath!),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[AppConstants.colorValue850]!,
                          highlightColor:
                              Colors.grey[AppConstants.colorValue800]!,
                          child: Container(
                            height: AppSize.s170,
                            width: AppSize.s120,
                            decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(AppSize.s8),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: AppColor.white,
                        ),
                        height: AppSize.s170,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: state.movieRecommendations!.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppSize.s8,
              crossAxisSpacing: AppSize.s8,
              childAspectRatio: AppSize.s0_7,
              crossAxisCount: AppSize.s3,
            ),
          );
        case RequestState.error:
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.messageMovieRecommendations),
            ),
          );
      }
    });
  }
}
