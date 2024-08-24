
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';


void nextScreen(context, page) {
  log(page.toString());
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));

}

void nextScreeniOS(context, page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers(context, page) {
  Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=> page), (route) => false);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> page,));
}

void nextScreenNoReturn(context, page) {
  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => page), (route) => false);
}
