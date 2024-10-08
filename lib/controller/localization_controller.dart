
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalizationController extends GetxController {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences, required this.dioClient}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  int _selectedIndex = 0;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int get selectedIndex => _selectedIndex;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstants().languageCode) ?? AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants().countryCode) ?? AppConstants.languages[0].countryCode
    );
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (_locale.languageCode == AppConstants.languages[index].languageCode) {
        _selectedIndex = index;
        update();
        break;
      }
    }
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants().languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants().countryCode, locale.countryCode!);
  }
}
