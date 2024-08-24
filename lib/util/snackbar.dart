import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/style.dart';

void showCustomDialog(String message, BuildContext context, {bool isError = true, Color? colors,bool isDelete = false, Function? onPressed,bool? hasOnpressed}) {
  showDialog(
    context: context,

    builder: (BuildContext context) {
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: Container(
            height: isDelete == true  ? 200 : hasOnpressed == true ? 250 : 210,
            child: Column(
              children: [
                isDelete == true ? customRegularTextStyle(text: 'Are you sure you want to delete?', fontSize: 16)
                    :  Lottie.asset(isError ? 'assets/animations/error.json' : 'assets/animations/success.json', height: 100, width: 100),
                SizedBox(height: 20),
                customRegularTextStyle(text: message, fontSize: 18,fontSize2: 18),
                isDelete == true ? SizedBox(height: 40): hasOnpressed == true ? SizedBox(height: 20) : SizedBox(height: 0),
                isDelete == true || hasOnpressed == true ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                    SizedBox(width: 40,),
                    ElevatedButton(
                      onPressed: () {
                        onPressed!();
                      },
                      child: Text('Okay'),
                    ),
                  ],
                ) :SizedBox()
              ],
            ),
          ),
          backgroundColor: colors ?? (isError ? ColorResources.errorColor : ColorResources.successColor),
          shadowColor: Colors.transparent,
        ),
      );
    },
  );
}