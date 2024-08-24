

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/screen/auth/register_screen.dart';
import 'package:miss_planet/screen/home/home_screen.dart';
import 'package:miss_planet/util/alert_dialog.dart';

import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
   static FToast fToast = FToast();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splash(){
    Future.delayed(const Duration(seconds: 3), () async {
      await Get.find<AuthController>().versionCheck().then((value) async {
        if (value == 'OK') {
          var vereion = Get.find<AuthController>().versionAPI;
          print(vereion);
          if (AppConstants.APP_VERSION != vereion) {
            CustomAppUpdateDialog.appUpdateDialog(
                Get.context!,
                title: 'UpdateAlert'.tr,
                content: 'Please_update_your_app_to_the_latest_version'.tr,
                onTap: () {
                 print('Update');
                });

          } else {
            await Get.find<AuthController>()
                .userInfo().then((value) async {
              if (value == 'OK') {

                // nextScreenReplace(Get.context!, homeScreen());
              } else {
                nextScreenReplace(Get.context!, homeScreen());
              }

            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    splash();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff111127),
      body: Center(
        child: Image(image: const AssetImage("assets/images/img.png"), width: 200, height: 200,),
      ),
    );
  }
}