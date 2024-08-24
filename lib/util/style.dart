import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/localization_controller.dart';

import 'dimensions.dart';


const robotoRegular = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

const robotoMedium = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);

const robotoBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

const robotoBlack = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w900,
);


final textStyleRegular = TextStyle(
  fontFamily: 'Inter',
  // fontFamily: Get.find<LocalizationController>().locale.languageCode == 'km'? 'Dangrek' : 'Roboto',
  fontWeight: FontWeight.w400,
  color: Colors.white,
  // color: Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
  fontSize: Dimensions.fontSizeDefault,
);

final textStyleLowMedium = TextStyle(
  fontFamily: 'Inter',
   color: Colors.white,
  // fontWeight: FontWeight.w800,
  // color: Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
  fontSize: Dimensions.fontSizeDefault,
);

final textStyleMedium = TextStyle(
  fontFamily: 'Inter',
   color: Colors.white,
  // fontWeight: FontWeight.w600,
  // color: Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
  fontSize: Dimensions.fontSizeDefault,
);

final textStyleBold = TextStyle(
  fontFamily: 'Inter',
   color: Colors.white,
  fontWeight: FontWeight.w700,
  // color: Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
  fontSize: Dimensions.fontSizeDefault,
);

final textStyleBlack = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w900,
  // color: Get.find<ThemeController>().darkTheme ? Colors.white : Colors.black,
  fontSize: Dimensions.fontSizeDefault,
);



class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor.isEmpty) {
      hexColor = '#03A9F4';
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

customRegularTextStyle({required String text, double? fontSize, Color? color, TextAlign? textAlign,double? fontSize2,double? height}){
  return GetBuilder<LocalizationController>(
    builder: (controller) {
      return Text(
        text.tr,
        style: TextStyle(
          fontFamily: controller.selectedIndex == 0 ? "Hanuman" : "Roboto",
          fontWeight: FontWeight.w400,
          height: height ?? 1.5,
          color: color ?? Colors.white,
          fontSize: controller.selectedIndex != 0 ? fontSize2 ?? fontSize : fontSize ?? Dimensions.fontSizeDefault,
        ),
        textAlign: textAlign ?? TextAlign.center,
      );
    },
  );
}
customBoldTextStyle({required String text, double? fontSize, Color? color,double? fontSize2,TextAlign? textAlign,double? height}){
  return GetBuilder<LocalizationController>(
    builder: (controller) {
      return Text(
        text.tr,
        style: TextStyle(
          fontFamily: controller.selectedIndex == 0 ? "Hanuman" : "Roboto",
          fontWeight: FontWeight.w700,
          color: color ?? Colors.white,
          height: height ?? 1.5,
          fontSize: controller.selectedIndex != 0 ? fontSize2 ?? fontSize : fontSize ?? Dimensions.fontSizeDefault,
        ),
        textAlign: textAlign ?? TextAlign.center,
        overflow: TextOverflow.ellipsis,

      );
    },
  );
}

