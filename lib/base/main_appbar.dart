
import 'package:flutter/material.dart';
import 'package:miss_planet/util/style.dart';
import 'package:get/get.dart';

// class MainAppBar extends StatelessWidget {
//   final String title;
//   final bool isCenterTitle;
//   const MainAppBar({super.key, required this.title, this.isCenterTitle = true});

//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(preferredSize: Size(, height), child: AppBar(
//       surfaceTintColor: Colors.transparent,
//       backgroundColor: Theme.of(context).primaryColor,
//       title: Text(title, style: textStyleMedium,),
//       centerTitle: isCenterTitle,
//     ));
//   }
// }

mainAppBar({required String title , bool isCenterTitle = true}){
  return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(Get.context!).primaryColor,
      title: Text(title, style: textStyleBold.copyWith(fontSize: 16),),
      centerTitle: isCenterTitle,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back, color: Colors.white,)),
    );
}