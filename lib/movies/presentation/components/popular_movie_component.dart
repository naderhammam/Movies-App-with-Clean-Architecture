import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_clean_architecture/core/utils/color_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/constants_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../core/utils/values_manager.dart';
import '../controller/movie_bloc/movie_bloc.dart';

class PopularMovieComponent extends StatelessWidget {
  const PopularMovieComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      builder: (context, state) {
        switch (state.popularState) {
          case RequestState.loading:
            return Container(
              color: AppColor.transparent,
              height: AppSize.s170,
              child: ListView.separated(
                  itemCount: AppConstants.cI10,
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[AppConstants.colorValue850]!,
                      highlightColor: Colors.grey[AppConstants.colorValue800]!,
                      child: Container(
                        height: AppSize.s170,
                        width: AppSize.s120,
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: AppSize.s8);
                  }),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: AppConstants.fadeDelay),
              child: SizedBox(
                height: AppSize.s170,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  itemCount: state.popularMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
                    return Container(
                      padding: const EdgeInsets.only(right: AppPadding.p8),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.movieDetailsRoute,
                            arguments: movie.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                          child: CachedNetworkImage(
                            width: AppSize.s120,
                            fit: BoxFit.cover,
                            imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                            placeholder: (context, url) => Shimmer.fromColors(
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
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s400,
              child: Center(child: Text(state.nowPlayingMessage)),
            );
        }
      },
    );
  }
}
