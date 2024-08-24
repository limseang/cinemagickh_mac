

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/controller/localization_controller.dart';

import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/data/model/language_model.dart';
import 'package:miss_planet/data/repository/artical_repository.dart';
import 'package:miss_planet/data/repository/auth_repository.dart';
import 'package:miss_planet/data/repository/film_repository.dart';
import 'package:miss_planet/data/repository/miss_repository.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future init() async  {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => DioClient(appBaseUrl: AppConstants.baseURL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => AuthRepository(dioClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => FilmRepository(dioClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ArticalRepository(dioClient: Get.find(), sharedPreferences: Get.find()));


  // Controller
  Get.lazyPut(() => AuthController(authRepository: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), dioClient: Get.find()));
  Get.lazyPut(() => FilmController(filmRepository: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ArticalController(articalRepository: Get.find(), sharedPreferences: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return languages;

  
}
