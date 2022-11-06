import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'constants_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColorLight: AppColor.lightPrimary,
    primaryColorDark: AppColor.darkPrimary,
    disabledColor: AppColor.grey1,
    splashColor: AppColor.grey1,
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: AppColor.darkGrey,

    // card view theme
    cardTheme: const CardTheme(
      color: AppColor.white,
      shadowColor: AppColor.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColor.primary,
        elevation: AppConstants.cD0,
        shadowColor: AppColor.lightPrimary,
        iconTheme: const IconThemeData(color: AppColor.white),
        titleTextStyle: getRegularStyle(
          fontSize: AppFontSize.s16,
          color: AppColor.white,
        )),

    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColor.grey1,
      buttonColor: AppColor.primary,
      splashColor: AppColor.lightPrimary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: AppColor.white, fontSize: AppFontSize.s17),
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              AppSize.s12,
            )))),

    // text theme
    textTheme: TextTheme(
        displayLarge:
            getLightStyle(color: AppColor.white, fontSize: AppFontSize.s22),
        headlineLarge: getSemiBoldStyle(
            color: AppColor.darkGrey, fontSize: AppFontSize.s16),
        titleMedium: getMediumStyle(
            color: AppColor.lightGrey, fontSize: AppFontSize.s14),
        bodyLarge: getRegularStyle(color: AppColor.grey1),
        bodySmall: getRegularStyle(color: AppColor.grey)),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: AppColor.grey, fontSize: AppFontSize.s14),
        labelStyle:
            getMediumStyle(color: AppColor.grey, fontSize: AppFontSize.s14),
        errorStyle: getRegularStyle(color: AppColor.error),

        // enabled border style
        enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.grey, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
