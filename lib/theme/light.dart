

import 'package:flutter/material.dart';
import 'package:miss_planet/util/color_resources.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Inter',
    
  primaryColor: const Color(0xff111127),
  // brightness: Brightness.dark,
  highlightColor: Colors.transparent,
  cardColor: Colors.white,
  hintColor: Colors.grey.shade400,
  splashColor: Colors.transparent,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
                    secondary: ColorResources.pinkColor, brightness: Brightness.dark),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  // primaryColorLight: ,
  dividerTheme: DividerThemeData(
    thickness: 0.1,
    color: Colors.grey.shade400,
  ),
  
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      
    ),
  ),
  
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
    
  ),
  // colorScheme: const ColorScheme.light(primary: Color(0xff3A91FF)),
  scaffoldBackgroundColor: const Color(0xff111127),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
