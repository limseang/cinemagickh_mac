import 'dart:async';


import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepository({required this.dioClient, required this.sharedPreferences});

  // TokenHelper _storage = TokenHelper();

  Future<void> saveUserToken({String? token}) async {
    dioClient.updateHeader(updateToken: token);
    try {
      await sharedPreferences.setString(AppConstants.token, token ?? "");
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> getUserToken() async {
    try {
      String? token = await sharedPreferences.getString(AppConstants.token);
      dioClient.updateHeader(updateToken: token);
      return token;
    } catch (e) {
      throw e.toString();
    }
  }



  Future deleteToken() async {
    try {
      await sharedPreferences.remove(AppConstants.token);
    } catch (e) {
      throw e.toString();
    }
  }

  Future versionCheck() async {
    try {
      final response = await dioClient.getData(AppConstants.versionCheck);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //signup
  Future signUp(
      {required String email, required String password, required String name, required String phone}) async {
    try {
      final response = await dioClient.postData(AppConstants.signUp, {
        "email": email,
        "password": password,
        "phone": phone,
        "name": name
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //login
  Future login({required String email, required String password}) async {
    try {
      final response = await dioClient.postData(AppConstants.signIn, {
        "email": email,
        "password": password,
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future userInfo({ required String fcm}) async {
    try {
      final response = await dioClient.postData(AppConstants.userInfo,{
        "fcm_token" : fcm
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future updateFCM({ required String fcm}) async {
  //   try {
  //     final response = await dioClient.postData(AppConstants.updateFCM,{
  //       "fcm_token" : fcm
  //     });
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future updatePhone({ required String phone}) async {
    try {
      final response = await dioClient.postData(AppConstants.updatePhone,{
        "phone" : phone
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changePassword({ required String oldPassword, String? newPassword}) async {
    try {
      final response = await dioClient.postData(AppConstants.changePassword,{
        "old_password" : '${oldPassword}',
        if(newPassword != null) "new_password" : newPassword
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future logout() async {
    try {
      final response = await dioClient.postData(AppConstants.logout,{});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteAccount() async {
    try {
      final response = await dioClient.deleteData(AppConstants.deleteAccount);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deviceInfo({
    required String token,
    required String deviceID,
    required String deviceName,
    required String deviceOS,
    required String deviceVersion,
    required String fcmToken,
    required String ipAddress,
    required String notificationStatus

  }) async {
    try {
      final response = await dioClient.postData(AppConstants.deviceInfo,{
        "token": token,
        "device_id": deviceID,
        "device_name": deviceName,
        "device_os": deviceOS,
        "device_os_version": deviceVersion,
        "fcm_token": fcmToken,
        "ip_address": ipAddress,
        "notification_status": notificationStatus
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeAvatar({required XFile file}) async {
    try {
      final response = await dioClient.postMultipartData(AppConstants.changeAvatar, {}, [MultipartBody('avatar', file)]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeName({required String name}) async {
    try {
      final response = await dioClient.postData(AppConstants.changeName, {
        "name": name
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future loginWithSocial({required String uuid,required String email, required String name, required String phone, required String comeFrom, String? avatar}) async {
    try {
      final response = await dioClient.postData(AppConstants.loginWithSocial, {
        "userUUID": uuid,
        "email": email,
        "name": name,
        "phone": phone,
        "avatar": avatar,
        "comeFrom": comeFrom

      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //Todo: Favorite
  Future ownFavorite() async {
    try {
      final response = await dioClient.getData(AppConstants.favorite);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //Report
  Future CreateReport({required String item_type, required String item_id, required String report_type, required String report_description,  XFile? image, String? sub_item}) async {
    try {
      final response = await dioClient.postMultipartData(AppConstants.createReport, {
        "item_type": item_type,
        "item_id": item_id,
        "report_type": report_type,
        "report_description": report_description,
        "sub_item": sub_item ?? ''
      }, [if(image != null) MultipartBody('image', image)]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // Continue To watch
  Future ownContinue() async {
    try {
      final response = await dioClient.getData(AppConstants.ownContinue);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future checkContinue ({required String film_id, required String episode_id, required String processing}) async{
    try{
      final response = await dioClient.postData(AppConstants.checkContinue, {
        "film_id": film_id,
        "episode_id": episode_id,
        "progressing": processing
      });
      return response;
    }
    catch(e){
      throw e.toString();
    }
  }

  Future detailContinue({required String id}) async {
    try {
      final response = await dioClient.getData(AppConstants.detailContinue + id);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateContinue({required String id, required String progressing, required String watchAt}) async {
    try {
      final response = await dioClient.postData(AppConstants.updateContinue + id, {
        "progressing": progressing,
        "watched_at": watchAt,

      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future byFilm({required String film_id}) async {
    try {
      final response = await dioClient.getData('${AppConstants.byFilm}$film_id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future newContinue({
    required String film_id,
    required String duration,
    required String film_type,
    required String episode_id,
    required String progressing,
    required String watched_at,
    required String episodeNumber,
  }) async {
    try {
      final response = await dioClient.postData(AppConstants.newContinue, {
        "film_id": film_id,
        "duration": duration,
        "film_type": film_type,
        "episode_id": episode_id,
        "progressing": progressing,
        "watched_at": watched_at,
        "episode_number": episodeNumber
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }



}