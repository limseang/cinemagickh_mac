

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/style.dart';

class VoteDialog {
  static void voteSuccessDialog(){
    Get.dialog(
      transitionCurve: Curves.easeInOutCubic,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              width: Get.width * 0.7,
              decoration:  BoxDecoration(color:Theme.of(Get.context!).primaryColor,borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                child: Material(
                  color: Theme.of(Get.context!).primaryColor,
                  child: Column(
                    children: [
                      LottieBuilder.asset("assets/images/done.json",height: 120,width: 120),
                      Text("Vote Success".tr,style: textStyleBold.copyWith(fontSize: 16),textAlign: TextAlign.center),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  static void showAlertDialog({required TextEditingController controller,required BuildContext context,required String missName,required void Function()? onConfirm}) {
    Get.dialog(
      transitionCurve: Curves.easeInOutCubic,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              decoration:  BoxDecoration(color:Theme.of(context).primaryColor,borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text("Confirmation".tr,style: textStyleBold.copyWith(fontSize: 16),textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Text("Are you sure you want to vote ${controller.text} for $missName?", style: textStyleRegular, textAlign: TextAlign.center,),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.grey.shade300.withOpacity(0.2)),
                                child: Text("Cancel".tr,style: textStyleRegular.copyWith(color: Colors.grey,fontSize: 14)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: onConfirm,
                              child: Container(
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: ColorResources.pinkColor),
                                child: Text("Confirm".tr,style: textStyleRegular.copyWith(color: Colors.white, fontSize: 14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Insufficient balance dialog 
  static void showInsufficientBalanceDialog({required BuildContext context}) {
    Get.dialog(
      transitionCurve: Curves.easeInOutCubic,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              decoration:  BoxDecoration(color:Theme.of(context).primaryColor,borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 34),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text("Insufficient Balance".tr,style: textStyleBold.copyWith(fontSize: 16),textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      Text("You don't have enough balance to vote", style: textStyleRegular, textAlign: TextAlign.center,),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.grey.shade300.withOpacity(0.2)),
                                child: Text("Cancel".tr,style: textStyleRegular.copyWith(color: Colors.grey,fontSize: 14)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Get.back();
                                // nextScreen(context, const TopupScreen());
                              },
                              child: Container(
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: ColorResources.pinkColor),
                                child: Text("Add Balance".tr,style: textStyleRegular.copyWith(color: Colors.white, fontSize: 14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}