

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miss_planet/screen/splash_screen.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/style.dart';

void showCustomSnackBar(String message, {bool isError = true, Color? colors}) {

  // Hide any existing snackbar
  if(SplashScreen.fToast != null) {
    SplashScreen.fToast.removeCustomToast();
  }
  if (message == 'success' && isError == true) {
    SplashScreen.fToast.removeCustomToast();
    return;
  }


  SplashScreen.fToast.removeCustomToast();
  SplashScreen.fToast.showToast(
    fadeDuration: const Duration(milliseconds: 100),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isError ?Colors.red: Colors.green
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Text(
              message,
              style: textStyleRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // if (showLoginButton)
          //   customUtilColor(
          //     width: 80,
          //     height: 30,
          //     isButton: true,
          //     isColor: true,
          //     border: true,
          //     child: Text(
          //       'Login'.tr,
          //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
          //     ),
          //     onTap: () {
          //       videoPlayerController?.pause();
          //       chewieController?.pause();
          //       SplashScreen.fToast.removeCustomToast();
          //       nextScreenNoReturn(context, LoginScreen(fromSplash: false));
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => LoginScreen(fromSplash: false)),
          //       // );


          //       SplashScreen.fToast.removeCustomToast();

          //     },
          //   )

        ],
      ),
    ),
  );


  // // Hide any existing snackbar
  // // lastShownMessage = message;
  //
  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //
  // // Check if the message indicates that the user is not logged in
  // bool showLoginButton = (message == AppConstants.noLogin || message == '${AppConstants.noLogin.tr}' || message == 'Invalid Token');
  // print('message: $message');


  // if(context.findAncestorStateOfType<State>()!.mounted == true ){
  //   resetTimer = Timer(Duration(seconds: 3), () {
  //     lastShownMessage = null;
  //     resetTimer?.cancel();
  //     context.findAncestorStateOfType<State>()!.mounted == false;
  //   });
  // }
  // else {
  //   lastShownMessage = null;
  //   resetTimer?.cancel();
  //   context.findAncestorStateOfType<State>()!.mounted == false;
  // }


}