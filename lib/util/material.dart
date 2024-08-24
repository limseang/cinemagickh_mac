


import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/screen/articals/artical_detail_screen.dart';
import 'package:miss_planet/screen/film/movie_screen.dart';
import 'package:miss_planet/screen/splash_screen.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/custom_image.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/style.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/util_controller.dart';
import 'color_resources.dart';

class material_App{

  static CustomButton({required String title, required Function onPressed, Color? color, width, height}){
    return Container(
      width: width!=null ? width.toDouble() : double.infinity,
      height: height!=null ? height.toDouble() : double.infinity,
      color: color,
      child: ElevatedButton(
        onPressed: (){
          onPressed();
        },
        child: customRegularTextStyle(text: title,color: Colors.blue,fontSize: 14),
      ),
    );
  }
  static CustomIcon({ required Function onPressed, Color? color, width, height, required IconData icon, Color? iconColor}){
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        width: width!=null ? width.toDouble() : double.infinity,
        height: height!=null ? height.toDouble() : double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(icon,color: iconColor,)
        ),
      ),
    );
  }
  static CustomAvatar({ required Function onPressed, Color? color, width, height, required image,required point, bool? isEditProfile }){
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: isEditProfile == true ? Stack(
        children: [
          CustomCacheImage(imageUrl: image, radius: 100 , cinema: false,),
      Positioned(
        bottom: 0,
        right: 0,
        child: Center(
            child: FaIcon(FontAwesomeIcons.camera,size: 15,)),
      ),
        ],
      )
          :  Container(
                height: 180,
                width: 180,

        child: CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(image ?? ''),
        ),
              ),
    );
  }

  static CustomIconButtom({required String title, required Function onPressed, Color? color, width, height, String? icon, Color? iconColor,bool? isImage = false}){
    return Column(
      children: [
        Container(
          width: width!=null ? width.toDouble() :52,
          height: height!=null ? height.toDouble() : 52,
          decoration: BoxDecoration(
            color: color != null ? color : Colors.grey.shade700,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 35,
                  height: 35,
                  child: Image.asset(icon!,fit: BoxFit.cover,)
                ),
              )
          ),
        ),
        SizedBox(height: 10,),
        customRegularTextStyle(text: title,fontSize2: 10,color: Color(0xffA0A0A0),fontSize: 12),
      ],
    );
  }

  String convertDate(String date){
    List<String> dateList = date.split('/');
    String day = dateList[0];
    String month = dateList[1];
    String year = dateList[2];
    String monthString = '';
    switch(month){
      case '01' || '1':
        monthString = 'jan'.tr;
        break;
      case '02' || '2':
        monthString = 'feb'.tr;
        break;
      case '03' || '3':
        monthString = 'mar'.tr;
        break;
      case '04' || '4':
        monthString = 'apr'.tr;
        break;
      case '05' || '5':
        monthString = 'may'.tr;
        break;
      case '06' || '6':
        monthString = 'jun'.tr;
        break;
      case '07' || '7':
        monthString = 'jul'.tr;
        break;
      case '08' || '8':
        monthString = 'aug'.tr;
        break;
      case '09' || '9':
        monthString = 'sep'.tr;
        break;
      case '10' || '10':
        monthString = 'oct'.tr;
        break;
      case '11' || '11':
        monthString = 'nov'.tr;
        break;
      case '12' || '12':
        monthString = 'dec'.tr;
        break;
    }
    return '$day \/ $monthString \/ $year';
  }

//convert timestamp to date
  String convertTimestampToDate(String timestamp){

    List<String> dateList = timestamp.split('T');
    String date = dateList[0];
    List<String> dateList2 = date.split('-');
    List<String> date3 = dateList2[2].split(' ');
    String year = dateList2[0];
    String month = dateList2[1];
    String day = dateList2[2] = date3[0];
    String monthString = '';

    switch(month){
      case '01' || '1':
        monthString = 'មករា';
        break;
      case '02' || '2':
        monthString = 'កុម្ភៈ';
        break;
      case '03' || '3':
        monthString = 'មិនា';
        break;
      case '04' || '4':
        monthString = 'មេសា';
        break;
      case '05' || '5':
        monthString = 'ឧសភា';
        break;
      case '06' || '6':
        monthString = 'មិថុនា';
        break;
      case '07' || '7':
        monthString = 'កក្កដា';
        break;
      case '08' || '8':
        monthString = 'សីហា';
        break;
      case '09' || '9':
        monthString = 'កញ្ញា';
        break;
      case '10' || '10':
        monthString = 'តុលា';
        break;
      case '11' || '11':
        monthString = 'វិច្ឆិកា';
        break;
      case '12' || '12':
        monthString = 'ធ្នូ';
        break;
    }


    return ' $day\ $monthString\ $year';



  }

  String formatMinuteToHour(dynamic minute){
    int hour = minute ~/ 60;
    int minute2 = minute % 60;
    //if less than 1 hour
    if(hour == 0){
      return '$minute2 minutes';
    }
    return "$hour ${'h'.tr} $minute2 ${'m'.tr}";
  }

  String formatSecondToHour(dynamic second){
    int hour = second ~/ 3600;
    int minute = (second % 3600) ~/ 60;
    int second2 = second % 60;
    //if less than 1 hour
    if(hour == 0){
      return '$minute ${'m'.tr} $second2 ${'s'.tr}';
    }
    return "$hour ${'h'.tr} $minute ${'m'.tr} $second2 ${'s'.tr}";
  }



  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0
    ) {
      time = format.format(date);
    }
    var formattedDate = DateFormat.yMMMd().format(date);
    if (diff.inDays > 0 && diff.inDays < 7) {
      time = '${diff.inDays} days ago';
    } else if (diff.inDays >= 7) {
      time = '${diff.inDays / 7} weeks ago';
    } else if (diff.inDays >= 30) {
      time = '${diff.inDays / 30} months ago';
    } else if (diff.inDays >= 365) {
      time = '${diff.inDays / 365} years ago';
    }
    return time;
  }

}

class CustomAlertDialog {
  static void alertDiaLog(BuildContext context,
      {required String title, required String content, void Function()? onTap,bool? ischangephone}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('$title',style: textStyleBlack.copyWith(fontSize: 15),),
        content: Text('$content'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: customBoldTextStyle(text: 'Cancel',fontSize: 15,color: Color(0xff27AE60)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ischangephone == true
              ? CupertinoDialogAction(
            child: customBoldTextStyle(text: 'Change',fontSize: 15,color: Colors.black),
            onPressed: onTap,
          )
              : CupertinoDialogAction(
              child: customBoldTextStyle(text: 'OK',fontSize: 15,color: ColorResources.errorColor),
              onPressed: onTap
          ),
        ],
      ),
    );
  }



  void showAlertDialog(BuildContext context,{ String? title, String? content, String? cancelActionText, String? confirmActionText, Function? onConfirm}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context,{ String? title, String? content, String? cancelActionText, String? confirmActionText, Function? onConfirm}) => CupertinoAlertDialog(
        title: customBoldTextStyle(text: '${title}'),
        content: customRegularTextStyle(text: '${content}'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(

            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: customRegularTextStyle(text: '${cancelActionText}')
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onConfirm!();
            },
            child: customRegularTextStyle(text: '${confirmActionText}')
          ),
        ],
      ),
    );
  }
}
Future openLinkWithCustomTab(BuildContext context, String url) async {
  try{
    await FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        //addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }catch(e){
    // show toast from get
    // openToast1(context, 'Cant launch the url');
    print("Cant launch the url");
    debugPrint(e.toString());
  }


}

Future openLinkWithCustomTabWithCallback(BuildContext context, String url) async {
  return await FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: CustomTabsOptions(

      colorScheme: CustomTabsColorScheme.dark,
      //addDefaultShareMenuItem: true,
      instantAppsEnabled: true,
      showTitle: true,
      urlBarHidingEnabled: true,

    ),
    safariVCOptions: SafariViewControllerOptions(
      barCollapsingEnabled: true,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,

    ),
  );
}

buildHomeItem({ Function? onPressed,required item, bool isNews = false,bool isMostWatch = false}) {

  return Container(
    padding: EdgeInsets.only(left: 20),
    alignment: Alignment.centerLeft,
    width: Get.width,
    height:  isNews == false ? 150 : 200,
    child: item.length == 0 ? Center(
      child: customBoldTextStyle(text: 'no_data',fontSize: 16,color: Colors.white),
    ) :isNews == false ? ListView.builder(
      itemCount: item.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: ()async{
            nextScreen(context, MovieScreen(
              id: item[index].id,
              poster: item[index].poster,
            ));
          },
          child: Container(
              margin: EdgeInsets.only(right: 16),
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                     
                    ),
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      imageUrl: item[index].poster,
                      fit: BoxFit.cover,

                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: Icon(Icons.star,color: Colors.yellow,size: 14,),
                                ),
                                SizedBox(width: 5,),
                                customRegularTextStyle(text:item[index].rating!, fontSize: 12,fontSize2: 12,)
                              ]
                          ),
                        )
                    ),
                  ),
                isMostWatch == true ?  Positioned(
                    bottom: 0,

                    child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.black,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4,bottom: 4),
                          child: customRegularTextStyle(text: '${'ep'.tr} : ${item[index].totalEpisode!}',fontSize: 14,fontSize2: 14,color: Colors.white),
                        )
                    ),
                  ): Container(),
                  item[index].subtitle == true  ? Positioned(
                    left: 0,
                    bottom: Get.height * 0.01,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4)),

                      ),
                      child: Center(
                        child: Icon(Icons.closed_caption,color: Colors.white,size: 24,)
                      ),
                    ),
                  ) : Container(),

                ],
              )
          ),
        );
      },
    ) :
    ListView.builder(
      itemCount: item.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: ()async{
            await Get.find<ArticalController>().getArticalDetail(id: item[index].id).then((value) {
              nextScreen(Get.context, ArticalDetail());
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        item[index].image == ''? Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Icon(Icons.image_not_supported,color: Colors.white,size: 50,),
                            )
                        )  :Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(item[index].image),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 0,
                          child: Container(

                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomLeft: Radius.circular(4))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: customRegularTextStyle(text: '${item[index].type}'.capitalizeFirst.toString(),fontSize: 12,color: Colors.white,fontSize2: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                        width: 170,

                        child: Text('${item[index].title}',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),

                    SizedBox(height: 10,),
                    Container(
                        width: 170,
                        child: Text('${item[index].description}',style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,) )
                  ],
                ),
                if(index != 9) SizedBox(width: 20,)
              ],
            ),
          ),
        );
      },
    ),
  );
}

buildProfileItem({required String title, required String icon,  required Function onPressed, bool isSigout = false }) => GestureDetector(
    onTap: () => onPressed(),
    child: Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color:
      isSigout == true ? Colors.red.shade500 :  Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(icon, width: 20, height: 20),
          // Lottie.asset(icon, width: 24, height: 24,repeat: false, ),
          SizedBox(width: 20),
          customRegularTextStyle(text: title, fontSize: 14, color: isSigout == true ? Colors.white : Colors.black),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: isSigout == true ? Colors.white :Colors.grey)
        ],
      ),
    ));


enum ButtonSheetType
{
  category,
  tag,
  type,
  country,
  artist,
}

Future<void> buttonSheetPriceList(BuildContext context,{required List data, required String title, required ButtonSheetType buttonSheetType}) async {

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(title),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: buttonSheetType == ButtonSheetType.country ? Text(data[index].flag,
                            style: TextStyle(fontSize: 32),
                          ) : buttonSheetType == ButtonSheetType.artist ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(data[index].profile ?? ''),
                          ) : null,
                          title: Text('${data[index].name }'),
                          trailing: buttonSheetType == ButtonSheetType.country ? Text(data[index].code) : buttonSheetType == ButtonSheetType.artist ? Text(data[index].nationalityLogo,style: TextStyle(fontSize: 16),) : null,

                          onTap: () {
                            switch(buttonSheetType) {
                              case ButtonSheetType.category:
                                Get.find<UtilController>().setSelectedCategory(data[index].name,data[index].id);
                                break;
                              case ButtonSheetType.tag:
                                Get.find<UtilController>().setSelectedTag(data[index].name,data[index].id);
                                break;
                              case ButtonSheetType.type:
                                Get.find<UtilController>().setSelectedType(data[index].name,data[index].id);
                                break;
                              case ButtonSheetType.country:
                                Get.find<UtilController>().setSelectedCountry(data[index].name,data[index].id);
                                break;
                                case ButtonSheetType.artist:
                                Get.find<UtilController>().setSelectArtist(data[index].name,data[index].id);
                                break;
                            }

                            Navigator.pop(context);
                          },
                        );
                      }

                  )
              )
            ],
          ),
        );
      });
}

class DashedLine extends CustomPainter {

  final double dashLength;
  final double dashGap;
  final Color dashColor;

  DashedLine({
    this.dashLength = 5,
    this.dashGap = 5,
    this.dashColor = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = 1;
    var startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashLength, 0), paint);
      startX += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget buildMainAppBar({required String title,bool hasMore = false, bool fromHome = false,bool fromDownload = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: ()async{
         if(fromHome == true || fromDownload == true) {
           var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.none) {
              //close app
              if(Platform.isAndroid){
                SystemNavigator.pop();
              }
              else if(Platform.isIOS){
                exit(0);
              }
            } else {
              nextScreenNoReturn(Get.context, SplashScreen());
            }
         }else{
           Get.back();
         }

        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
      ),
      customBoldTextStyle(text: '${title.tr}', fontSize: 20, color: Colors.white),
      hasMore == true ? IconButton(
        onPressed: (){},
        icon: Icon(Icons.more_vert, color: Colors.white,),
      ) : Container(
        width: Get.width / 8,
        color: Colors.transparent,
      ),
    ],
  );
}

Widget buildLoading (){
  return Center(
    child: Container(
      width: 200,
      height: 200,
      child: Lottie.asset('${AppConstants.customLoading}'),
    ),
  );

}

Widget buildCustomAdminTextField({required String title, required TextEditingController controller, required String hintText, required TextInputType textInputType, required bool obscureText, required Function(String) onChanged, bool? description = false}){
  return Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        child:  Text('${title}',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      Container(
        width: Get.width,
        height: description == true ? 100 : 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.15),
        ),
        child: TextFormField(
          maxLines: description == true ? 5 : 1,
          controller: controller,
          onChanged: (value){
            onChanged(value);
          },
          style: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),
          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: '${hintText}',

            hintStyle: TextStyle(color: Colors.grey.shade500),
            contentPadding: EdgeInsets.only(left: 10),
          ),
        ),
      ),
    ],
  );


}
class CustomToast {
  static void show(String title, {Color? color}) {
    Fluttertoast.showToast(
      msg: title,
      backgroundColor: color ?? Colors.purple,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
class CustomFormatNumber {
  static String convert(int number) {
    if (number >= 10000000) {
      double millions = number / 1000000;
      return '${millions.toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      double thousands = number / 1000;
      return '${thousands.toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }
}
class CustomFormatTime {
  static String convert(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int hours = (seconds / 3600).floor();
    int minutes = ((seconds % 3600) / 60).floor();
    int remainingSeconds = (seconds % 60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
class ConvertSecToMin {
  static String convert(int seconds) {
    int minutes = (seconds / 60).floor();
   if(minutes > 60){
     int hours = (minutes / 60).floor();
     int remainingMinutes = (minutes % 60);
     return "${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
    }
    int remainingSeconds = (seconds % 60);


    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }


}




