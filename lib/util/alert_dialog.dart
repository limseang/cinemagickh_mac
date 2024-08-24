// ignore_for_file: prefer_const_constructors


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/style.dart';


class CustomAlertDialog {
  static void alertDiaLog(
    BuildContext context,
    {required String title, required String content, void Function()? onTap,bool? isChangePhone}
  ) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title,style: textStyleBlack.copyWith(fontSize: 15)),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('cancel'.tr, style: textStyleMedium.copyWith(color: Color(0xff27AE60))),
            onPressed: () => Navigator.of(context).pop(),
          ),
          isChangePhone == true ? CupertinoDialogAction(
            onPressed: onTap,
            child: Text('ok'.tr, style: textStyleMedium.copyWith(color: Colors.black)),
          ) : CupertinoDialogAction(
            onPressed: onTap,
            child: Text('delete'.tr, style: textStyleMedium.copyWith(color: ColorResources.errorColor))
          ),
        ],
      ),
    );
  }
}

class CustomCmtDialog
{


  static void showCustomCupertinoActionSheet(
      BuildContext context, {
        required String userAvatar,
        required String userName,
        required String content,
        void Function()? onTap,
        required int type,
        required int id,
      }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Choose Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black,
            ),
          ),
          message: Text(
            'Select the profile you want to comment with:',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemGrey,
            ),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                // Uncomment and use this to trigger the comment action.
                // Get.find<ArticalController>().createComment(
                //   id: id,
                //   comment: content,
                //   type: type,
                //   confess: 0,
                // );
              },
              child: _buildProfileOption(userAvatar, userName),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                // Uncomment and use this to trigger the comment action.
                // Get.find<ArticalController>().createComment(
                //   id: id,
                //   comment: content,
                //   type: type,
                //   confess: 1,
                // );
              },
              child: _buildProfileOption(

                'assets/image/logo_app.png',
                'Anonymous',
                isAnonymous: true
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildProfileOption(String avatarUrl, String name,{bool isAnonymous = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          isAnonymous == true ?
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              avatarUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ) :
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              avatarUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: CupertinoColors.black,
            ),
          ),
        ],
      ),
    );
  }


}

class CustomAppUpdateDialog {
  static void appUpdateDialog(
    BuildContext context,
    {required String title, required String content, void Function()? onTap}
  ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title)),
        content: Text(content),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18,),
        titlePadding: EdgeInsets.only(top: 20),
        contentPadding: EdgeInsets.only( bottom:10,top: 20,left: 20,right: 20),
        actions: <Widget>[

          TextButton(
            onPressed: () {
              // nextScreenReplace(Get.context!, homeScreen());
            },
            child: Text('cancel'.tr),
          ),

          TextButton(
            onPressed: onTap,
            child: Text('okay'.tr),
          ),
        ],
      );
    },
  );

  }
  static void serverDownDialog(
    BuildContext context,
    {required String title, required String content, void Function()? onTap}
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: Text(content),
          alignment: Alignment.center,
          backgroundColor: Colors.red,
          actionsAlignment: MainAxisAlignment.center,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16,),
          titlePadding: EdgeInsets.only(top: 20,right: 20,left: 20),
          contentTextStyle: TextStyle(color: Colors.black, fontSize: 14,),
          contentPadding: EdgeInsets.only( bottom:20,top: 20,right: 20,left: 40),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12),
                child: TextButton(
                  onPressed: onTap,
                  child: Text('okay'.tr,style: TextStyle(
                    color: Colors.black
                  ),),
                ),
              ),
            ),
          ],
        );
      },
    );

  }
}
