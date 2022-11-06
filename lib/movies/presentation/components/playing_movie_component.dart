import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_clean_architecture/core/utils/constants_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/font_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/strings_manager.dart';
import 'package:movie_app_with_clean_architecture/core/utils/values_manager.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/enums_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../controller/movie_bloc/movie_bloc.dart';

class PlayingMovieComponent extends StatelessWidget {
  const PlayingMovieComponent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingState != current.nowPlayingState,
      builder: (context, state) {
        switch (state.nowPlayingState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: AppConstants.fadeDelay),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: AppSize.s400,
                  viewportFraction: AppConstants.cD1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {},
                ),
                items: state.nowPlayingMovies.map(
                  (item) {
                    return GestureDetector(
                      key: const Key(AppConstants.keyOpenMovieDetail),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.movieDetailsRoute,
                          arguments: item.id,
                        );
                      },
                      child: Stack(
                        children: [
                          ShaderMask(
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
                                  AppConstants.cD0_3,
                                  AppConstants.cD0_5,
                                  AppConstants.cD1,
                                ],
                              ).createShader(
                                Rect.fromLTRB(
                                  AppConstants.cD0,
                                  AppConstants.cD0,
                                  rect.width,
                                  rect.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              height: AppSize.s560,
                              imageUrl:
                                  ApiConstance.imageUrl(item.backdropPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppPadding.p16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.circle,
                                        color: AppColor.redAccent,
                                        size: AppSize.s16,
                                      ),
                                      SizedBox(width: AppSize.s4),
                                      Text(
                                        AppStrings.nowPlaying,
                                        style: TextStyle(
                                          fontSize: AppSize.s16,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppPadding.p16),
                                  child: Text(
                                    item.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: AppFontSize.s24,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
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
