import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/data/model/ContinueByFilmModel.dart';
import 'package:miss_planet/data/model/ContinueToWatchModel.dart';
import 'package:miss_planet/data/model/DetailContinueModel.dart';
import 'package:miss_planet/data/model/favoriteListModel.dart';
import 'package:miss_planet/data/model/userModel.dart';

import 'package:miss_planet/data/repository/auth_repository.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/screen/home/home_screen.dart';
import 'package:miss_planet/util/alert_dialog.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class AuthController extends GetxController implements GetxService {

  final AuthRepository authRepository;
  final SharedPreferences sharedPreferences;

  AuthController(
      {required this.authRepository, required this.sharedPreferences}) {}

  // set
  UserModel? _userModel;
  FavoriteListModel? _favoriteListModel;
  ContinueToWatchModel? _continueToWatchModel;
  DetailContinueModel? _detailContinueModel;
  ContinueByFilmModel? _continueByFilmModel;

  //Auth Helper
  bool? _hasEmail = false;
  bool? _hasPhone = false;
  bool? _hasPassword = false;
  bool? _hasName = false;

  String? _fcm;
  String _token = "";
  String? ipAddress;
  bool? _isLogin = false;
  String deviceToken = "";
  String deviceName = "";
  bool _isLoading = false;
  bool _isErorr = false;
  String? _errorCode;
  bool _isNotLogin = true;
  bool _otpSend = false;
  String? _verifyOTPID;
  String? _versionAPI;
  int? _subtitleIndex;
  bool? _passAds;

  /* Continue To Watch */
  String? _filmURL;
  String? _episodeID;
  String? _filmID;
  String? _episodeNumber;
  String? _startTime;
  String? _continueID;
  String? _subtitleURL;

  // get
  UserModel? get userModel => _userModel;
  FavoriteListModel? get favoriteListModel => _favoriteListModel;
  ContinueToWatchModel? get continueToWatchModel => _continueToWatchModel;
  DetailContinueModel? get detailContinueModel => _detailContinueModel;
  ContinueByFilmModel? get continueByFilmModel => _continueByFilmModel;

  //AuthHelper
  bool? get hasEmail => _hasEmail;
  bool? get hasPhone => _hasPhone;
  bool? get hasPassword => _hasPassword;
  bool? get hasName => _hasName;


  String get token => _token;
  String? get fcm => _fcm;
  bool? get isLogin => _isLogin;
  bool get isLoading => _isLoading;
  bool get isErorr => _isErorr;
  String? get errorCode => _errorCode;
  bool get isNotLogin => _isNotLogin;
  bool get otpSend => _otpSend;
  String? get verifyOTPID => _verifyOTPID;
  String? get versionAPI => _versionAPI;
  int? get subtitleIndex => _subtitleIndex;
  bool? get passAds => _passAds;


  /* Continue To Watch */
  String? get filmURL => _filmURL;
  String? get episodeID => _episodeID;
  String? get filmID => _filmID;
  String? get episodeNumber => _episodeNumber;
  String? get startTime => _startTime;
  String? get continueID => _continueID;
  String? get subtitleURL => _subtitleURL;


  //AuthHelper

  setHasEmail(bool hasEmail){
    _hasEmail = hasEmail;
    update();
  }

  setHasPhone(bool hasPhone){
    _hasPhone = hasPhone;
    update();
  }

  setHasPassword(bool hasPassword){
    _hasPassword = hasPassword;
    update();
  }

  setHasName(bool hasName){
    _hasName = hasName;
    update();
  }

  //   //

  setPassAds(bool passAds){
    _passAds = passAds;
    update();
  }

  setSubtitleIndex(int subtitleIndex){
    _subtitleIndex = subtitleIndex;
    update();
  }

  setSubtitleURL(String subtitleURL){
    _subtitleURL = subtitleURL;
    update();
  }

  setContinueID(String continueID){
    _continueID = continueID;
    update();
  }

  setStartTime(String startTime){
    _startTime = startTime;
    update();
  }

  setFilmID(String filmID){
    _filmID = filmID;
    update();
  }

  setEpisodeNumber(String episodeNumber){
    _episodeNumber = episodeNumber;
    update();
  }

  setEpisodeID(String episodeID){
    _episodeID = episodeID;
    update();
  }


  setFilmURL(String filmURL){
    _filmURL = filmURL;
    update();
  }


  setNotLogin(bool isNotLogin){
    _isNotLogin = isNotLogin;
    update();
  }

  setIsLoading (bool isLoading){
    _isLoading = isLoading;
    update();
  }

  setFcm(String fcm){
    _fcm = fcm;
    update();
  }

  setToken(String token){
    _token = token;
    update();
  }

  setErorr(bool isErorr){
    _isErorr = isErorr;
    update();
  }

  setErrorCode(String errorCode){
    _errorCode = errorCode;
    update();
  }



  Future versionCheck() async {
    try {
      Response apiResponse = await authRepository.versionCheck();
      print(apiResponse.body);
      if (apiResponse.statusCode == 200) {

        _versionAPI = apiResponse.body['data']['version'];
        return 'OK';
      } else {
        CustomAppUpdateDialog.serverDownDialog(
            Get.context!,
            title: 'our_server_is_under_maintenance'.tr,
            content: 'please_come_back_again_latter'.tr,
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            }
        );
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

//signup
  Future signUp({required String email, required String password, required String name, required String phone}) async {
    try {
      Response apiResponse = await authRepository.signUp(email: email, password: password, name: name, phone: phone);
      print(apiResponse.body);
      if (apiResponse.statusCode == 200) {
       nextScreenNoReturn(Get.context!, LoginScreen());
        return apiResponse;
      } else {
        showCustomSnackBar("${apiResponse.body['error']}",isError: true);
        return apiResponse;
      }

    } catch (e) {
      throw e.toString();
    }
  }


  // Future<String> fetchData() async {
  //   final url = 'https://jsonplaceholder.typicode.com/posts/1'; // Replace with your URL
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return 'No internet connection';
  //   }
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       if (data != null && data is Map && data.containsKey('title')) {
  //         return data['title'];
  //       } else {
  //         throw Exception('Invalid data format');
  //       }
  //     } else if (response.statusCode == 404) {
  //       // Handle 404 error specifically
  //       return 'Error 404: Resource not found';
  //     } else {
  //       // Handle other HTTP errors
  //       throw Exception('Failed to load data: ${response.statusCode}\n${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load data: $e');
  //   }
  // }

  //login
  Future login({required String email, required String password, }) async {
    try {
      Response apiResponse = await authRepository.login(email: email, password: password);
      print(apiResponse.body);
      if (apiResponse.body['code'] == 200) {

        setToken(apiResponse.body['data']['token']);
        authRepository.saveUserToken(token: apiResponse.body['data']['token']);
        sharedPreferences.setString(AppConstants.token, '${apiResponse.body['data']['token']}');
        sharedPreferences.setBool(AppConstants().isLogin.toString(), true);
        _isLogin = true;
        update();
        if (_token.isNotEmpty) {
          await authRepository.saveUserToken(token: _token);
          _isNotLogin = false;
          Get.snackbar('welcome'.tr, '${apiResponse.body['data']['user']['name']}',colorText: ColorResources.backgroundBannerColor);
          await userInfo();
          update();
          return 'ok';
        }
        else {

          return apiResponse;
        }
        return apiResponse;
      }
      else {
        showCustomSnackBar("${apiResponse.body['message']}");
        return apiResponse;
      }
    } catch (e) {
      print('error $e');
      throw e.toString();
    }
  }

  Future logout ()async{
    try{
      Response apiResponse = await authRepository.logout();
      print('logout ${apiResponse.body}');
      if(apiResponse.body['message'] == 'Unauthenticated' ||apiResponse.body['message'] == 'Unauthenticated.' ){
        await authRepository.deleteToken();
        sharedPreferences.remove(AppConstants.token);
        nextScreenReplace(Get.context!, LoginScreen());
        return apiResponse;
      }
      if(apiResponse.statusCode == 200){
        await authRepository.deleteToken();
        sharedPreferences.remove(AppConstants.token);
        nextScreenReplace(Get.context!, LoginScreen());
        return apiResponse;
      }else{
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  Future deleteAccount()async{
    try{
      Response apiResponse = await authRepository.deleteAccount();
      if(apiResponse.statusCode == 200){
        await authRepository.deleteToken();
        sharedPreferences.remove(AppConstants.token);
        nextScreenReplace(Get.context!, LoginScreen());
        return apiResponse;
      }else{
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  Future userInfo({bool? fromGift = false})async{
    try{

      Response apiResponse = await authRepository.userInfo(fcm: "test");
      print(apiResponse.body);
      if(apiResponse.statusCode == 200){
        _userModel = UserModel.fromJson(apiResponse.body);
        _isLogin = true;
        sharedPreferences.setBool(AppConstants().isLogin.toString(), true);
        getDeviceInfo(fcm: "test");
        fromGift == false ? nextScreenNoReturn(Get.context!, homeScreen(userModel: _userModel )) :
        null;
        _isNotLogin = false;
        update();
        return 'OK';
      }else{
        return 'nologin';
      }
    }catch(e){

      throw e.toString() ;
    }
  }


  Future updatePhone({required String phone})async{
    try{
      Response apiResponse = await authRepository.updatePhone(phone: phone);
      if(apiResponse.statusCode == 200){
        _userModel!.data!.phone = apiResponse.body['data']['phone'];
        update();
        return 'ok';
      }else{
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  Future changePassword({required String oldPassword,  String? newPassword, bool isCheck = false})async{
    try{

      Response apiResponse = isCheck == true ? await authRepository.changePassword(oldPassword: oldPassword) : await authRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword);
      if(apiResponse.body['code'] == 200){
        if(isCheck == true) {
          return 'check ok';
        }
        else{
          _userModel!.data!.password = apiResponse.body['data']['password'];
          return 'ok';
        }
      }else{
        showCustomSnackBar('${apiResponse.body['message']}');
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  //Todo : GetIPNetwork
  Future<void> getNetworkIP() async {
    var response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      ipAddress = response.body;
      update();
    } else {
      throw Exception('Failed to get network IP');
    }
  }

  Future<void> getDeviceInfo({required String fcm})async{
    await getNetworkIP();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // _fcm = await FirebaseMessaging.instance.getToken();
    if(Platform.isMacOS){
      MacOsDeviceInfo macInfo = await deviceInfo.macOsInfo;
      deviceToken = macInfo.model;
      deviceName = macInfo.model;
    }


    PushDeviceInfo(
        token: token,
        deviceID: deviceToken,
        deviceName: deviceName,
        deviceOS: Platform.operatingSystem,
        deviceVersion:  Platform.operatingSystemVersion,
        fcmToken: fcm,
        ipAddress: ipAddress!,
        notificationStatus: '1');
  }

  Future PushDeviceInfo({
    required String token,
    required String deviceID,
    required String deviceName,
    required String deviceOS,
    required String deviceVersion,
    required String fcmToken,
    required String ipAddress,
    required String notificationStatus
  })async{
    try{

      Response apiResponse = await authRepository.deviceInfo(
          token: _token,
          deviceID: deviceID,
          deviceName: deviceName,
          deviceOS: deviceOS,
          deviceVersion: deviceVersion,
          fcmToken: fcmToken,
          ipAddress: ipAddress,
          notificationStatus: notificationStatus
      );
      if(apiResponse.statusCode == 200){
        return apiResponse;
      }else{
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  Future uploadAvatar(XFile file)async{
    try{
      _isLoading = true;
      Response apiResponse = await authRepository.changeAvatar(file: file);
      if(apiResponse.statusCode == 200){
        _userModel!.data!.avatar = apiResponse.body['data']['avatar'];
        update();
        _isLoading = false;
        return 'ok';
      }else{
        showCustomSnackBar('erorr',);
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  Future changeName(String name)async{
    try{
      _isLoading = true;
      Response apiResponse = await authRepository.changeName(name: name);
      if(apiResponse.statusCode == 200){
        _userModel!.data!.name = apiResponse.body['data']['name'];
        update();
        _isLoading = false;
        return 'ok';
      }else{
        return apiResponse;
      }
    }catch(e){
      throw e.toString();
    }
  }

  // Future signInWithGoogle() async {
  //   final _firebaseAuth = FirebaseAuth.instance;
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   if(googleUser != null){
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     final authResult = await _firebaseAuth.signInWithCredential(credential);
  //     final firebaseUser = authResult.user;
  //
  //     if (firebaseUser != null) {
  //       try{
  //         _fcm = await FirebaseMessaging.instance.getToken();
  //         String _userUUID = firebaseUser.uid;
  //         authRepository.loginWithSocial(
  //             uuid: _userUUID,
  //             email: firebaseUser.email ?? "",
  //             avatar: firebaseUser.photoURL ?? "",
  //             name: firebaseUser.displayName ?? firebaseUser.email.toString(),
  //             phone: firebaseUser.phoneNumber ?? "0",comeFrom: 'Google' ).then((value) async {
  //           if(value.statusCode == 200) {
  //             if (value.body['status'] == 501) {
  //               showCustomDialog('You_already_delete_your_account_please_use_other_email_to_login'.tr, Get.context!);
  //               // showCustomSnackBar("You already delete your account", Get.context!);
  //               return firebaseUser;
  //             }
  //             else {
  //               setToken(value.body['token']);
  //               sharedPreferences.setString(_token, '${value.body['token']}');
  //               userInfo(fcm: _fcm ?? "");
  //               setToken(value.body['token']);
  //               authRepository.saveUserToken(token: value.body['token']);
  //               if (_token.isNotEmpty) {
  //                 await authRepository.saveUserToken(token: _token);
  //                 _isNotLogin = false;
  //                 Get.snackbar('welcome'.tr, '${value.body['data']['user']}',
  //                     colorText: ColorResources.backgroundBannerColor);
  //                 await userInfo(fcm: _fcm ?? "");
  //               }
  //               else {
  //                 return firebaseUser;
  //               }
  //             }
  //           }
  //
  //           else{
  //             showCustomSnackBar("something_when_wrong".tr, Get.context!);
  //             return firebaseUser;
  //           }
  //         });
  //
  //         return firebaseUser;
  //       }
  //       catch(e) {
  //         setErorr(true);
  //         setErrorCode('sss');
  //         throw e.toString();
  //       }
  //     }
  //     else{
  //       showCustomSnackBar("login_failed".tr, Get.context!);
  //       return firebaseUser;
  //     }
  //   }
  //   else {
  //     showCustomSnackBar("login_failed".tr, Get.context!);
  //     return 'failed';
  //   }
  //
  //
  //
  //
  //
  // }

  Future loginWithApple()async{
    try{
      final _firebaseAuth = FirebaseAuth.instance;
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'cinemagickh.news',
          redirectUri: Uri.parse('https://popcornnews-31b43.firebaseapp.com/__/auth/handler',
          ),
        ),
      );
      final appleCredential = OAuthProvider('apple.com').credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      final authResult = await _firebaseAuth.signInWithCredential(appleCredential);
      final firebaseUser = authResult.user;
      if (firebaseUser != null) {
        _fcm = await FirebaseMessaging.instance.getToken();
        String _userUUID = firebaseUser.uid;

        authRepository.loginWithSocial(
            uuid: _userUUID,
            email: firebaseUser.email ?? "",
            avatar: firebaseUser.photoURL ?? "",
            name: firebaseUser.displayName ?? firebaseUser.email.toString(),
            phone: firebaseUser.phoneNumber ?? "",comeFrom: 'Apple').then((value) async {
          if(value.statusCode == 200){

            setToken(value.body['token']);
            authRepository.saveUserToken(token: value.body['token']);
            sharedPreferences.setString(AppConstants.token, '${value.body['token']}');
            if (_token.isNotEmpty) {
              await authRepository.saveUserToken(token: _token);
              _isNotLogin = false;
              Get.snackbar('welcome'.tr, '${value.body['data']['user']}',colorText: ColorResources.backgroundBannerColor);
              await userInfo();
            }
            else {
              return firebaseUser;
            }
          }
        });


        return firebaseUser;
      }
      else{
        showCustomSnackBar("login_failed".tr);
        return firebaseUser;
      }
    }
    catch(e){
      setErorr(true);
      setErrorCode('sss');
      throw e.toString();

    }

  }
  //
  // Future loginWithFacebook()async {
  //   try {
  //     final _firebaseAuth = FirebaseAuth.instance;
  //     final result = await FacebookAuth.instance.login();
  //     final facebookCredential = FacebookAuthProvider.credential(
  //         result.accessToken!.token);
  //     final authResult = await _firebaseAuth.signInWithCredential(
  //         facebookCredential);
  //     final firebaseUser = authResult.user;
  //     if (firebaseUser != null) {
  //       _fcm = await FirebaseMessaging.instance.getToken();
  //       String _userUUID = firebaseUser.uid;
  //       print('avatar ${firebaseUser.photoURL}');
  //       authRepository.loginWithSocial(
  //           uuid: _userUUID,
  //           email: firebaseUser.email ?? "",
  //           name: firebaseUser.displayName ?? firebaseUser.email.toString(),
  //           phone: firebaseUser.phoneNumber ?? "",
  //           avatar: firebaseUser.photoURL ?? "",
  //           comeFrom: 'Facebook').then((value) async {
  //         if (value.statusCode == 200) {
  //           print('value ${value.body['token']}');
  //           setToken(value.body['token']);
  //           authRepository.saveUserToken(token: value.body['token']);
  //           sharedPreferences.setString(
  //               AppConstants.token, '${value.body['token']}');
  //           if (_token.isNotEmpty) {
  //             await authRepository.saveUserToken(token: _token);
  //             Get.snackbar('welcome', '${value.body['user']['name']}',colorText: ColorResources.backgroundBannerColor);
  //             await userInfo(fcm: _fcm ?? "");
  //           }
  //           else {
  //             return firebaseUser;
  //           }
  //         }
  //       });
  //
  //       return firebaseUser;
  //     }
  //     else {
  //       showCustomSnackBar("Login Failed", Get.context!);
  //       return firebaseUser;
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // Future TheAppleLogin()async{
  //   final _firebaseAuth = FirebaseAuth.instance;
  //   final result = await TheAppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);
  //   // if(result.status == appleAuthorizationStatus.authorized){
  //   //   try{
  //   //     final appleCredential = OAuthProvider('apple.com').credential(
  //   //       idToken: String.fromCharCodes(result.credential!.identityToken!),
  //   //       accessToken: String.fromCharCodes(result.credential!.authorizationCode!),
  //   //     );
  //   //     final authResult = await _firebaseAuth.signInWithCredential(appleCredential);
  //   //     final firebaseUser = authResult.user;
  //   //     if (firebaseUser != null) {
  //   //       _fcm = await FirebaseMessaging.instance.getToken();
  //   //       String _userUUID = firebaseUser.uid;
  //   //
  //   //       authRepository.loginWithSocial(
  //   //           uuid: _userUUID,
  //   //           email: firebaseUser.email ?? "",
  //   //           avatar: firebaseUser.photoURL ?? "",
  //   //           name: firebaseUser.displayName ?? firebaseUser.email.toString(),
  //   //           phone: firebaseUser.phoneNumber ?? "",comeFrom: 'Apple').then((value) async {
  //   //         if(value.statusCode == 200){
  //   //
  //   //           setToken(value.body['token']);
  //   //           authRepository.saveUserToken(token: value.body['token']);
  //   //           sharedPreferences.setString(AppConstants.token, '${value.body['token']}');
  //   //           if (_token.isNotEmpty) {
  //   //             _isNotLogin = false;
  //   //             await authRepository.saveUserToken(token: _token);
  //   //             Get.snackbar('welcome'.tr, '${value.body['user']}',colorText: ColorResources.backgroundBannerColor);
  //   //             await userInfo(fcm: _fcm ?? "");
  //   //           }
  //   //           else {
  //   //             return firebaseUser;
  //   //           }
  //   //         }
  //   //       });
  //   //     }
  //   //
  //   //     else if(result.status == appleAuthorizationStatus.error){
  //   //
  //   //     }
  //   //     else if(result.status == appleAuthorizationStatus.cancelled){
  //   //
  //   //
  //   //     }
  //   //     else{
  //   //       showCustomSnackBar("login_failed".tr, Get.context!);
  //   //       return firebaseUser;
  //   //     }
  //   //
  //   //
  //   //   }catch(e){
  //   //     setErorr(true);
  //   //     setErrorCode(e.toString());
  //   //     throw e.toString();
  //   //   }
  //   // }
  //
  // }

  //Todo: Favorite
  Future ownFavorite() async {
    try {
      Response apiResponse = await authRepository.ownFavorite();
      if (apiResponse.body['code'] == 200) {
        _favoriteListModel = FavoriteListModel.fromJson(apiResponse.body);
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future CreateReport({required String item_type, required String item_id, required String report_type, required String report_description,  XFile? image,String? sub_item})async{
    try{
      Response apiResponse = await authRepository.CreateReport(item_type: item_type, item_id: item_id, report_type: report_type, report_description: report_description, image: image,sub_item: sub_item);
      if(apiResponse.body['code'] == 200){

        return 'ok';
      }else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  // Continue To watch
  Future ownContinue() async {
    try {
      Response apiResponse = await authRepository.ownContinue();
      print(apiResponse.body);
      print('errrorrrrr');
      if (apiResponse.body['code'] == 200) {
        print('jol tah');
        _continueToWatchModel = ContinueToWatchModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      } else {
        return 'error hz kon ';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future checkContinue ({required String film_id, required String episode_id, required String processing}) async {
    try{
      Response apiResponse = await authRepository.checkContinue(film_id: film_id, episode_id: episode_id, processing: processing);
      if(apiResponse.statusCode == 200){
        if(apiResponse.body == 'null') {
          return 'no';
        }
        else{
          print(apiResponse);
          return 'ok';
        }
      }else{
        print(apiResponse);
        print('----------');

        return 'no';
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future detailContinue({required String id}) async {
    try {
      Response apiResponse = await authRepository.detailContinue(id: id);
      if (apiResponse.body['code'] == 200) {
        _detailContinueModel = DetailContinueModel.fromJson(apiResponse.body);
        update();
        print(_detailContinueModel!.data!.films);

        return true;
      } else {
        print(apiResponse.body);
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateContinue({required String filmID,required String id, required String progressing, required String watchAt, bool? isNext = false, bool? isPrevious = false}) async{
    try{
      Response apiResponse = await authRepository.updateContinue(id: id, progressing: progressing, watchAt: watchAt);
      print(apiResponse.body);
      print('dsfasdfasdfasdfas');
      print('filme Id ${id}');

      if(apiResponse.body['code'] == 200){
        byFilm(film_id: filmID, isNext: isNext,isPrevious: isPrevious);
        update();
        return 'ok';
      }else{
        return apiResponse;
      }
    }catch(e){
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
    bool? isNext = false,
    bool? isPrevious = false,
  }) async {
    try {
      Response apiResponse = await authRepository.newContinue(
          film_id: film_id,
          duration: duration,
          film_type: film_type,
          episode_id: episode_id,
          progressing: progressing,
          episodeNumber: episodeNumber,
          watched_at: watched_at);
      print(apiResponse.body);
      print('------------------- ${episodeNumber}');
      if (apiResponse.body['code'] == 200) {
        print(apiResponse);
        byFilm(film_id: film_id, isNext: isNext,isPrevious: isPrevious);

        update();
        print('-------------------ddd');
        return 'ok';
      } else {
        print(apiResponse);
        print('fsdfds');
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future byFilm({required String film_id, bool? isNext = false, bool? isPrevious = false}) async {
    try {
      Response apiResponse = await authRepository.byFilm(film_id: film_id);
      print(apiResponse.body);
      print('-------------------');
      if (apiResponse.body['code'] == 200) {
        print(apiResponse.body);
        _continueByFilmModel = ContinueByFilmModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      } else {
        if(apiResponse.body['message'] == 'Unauthenticated.'){
          showCustomSnackBar('you_have_to_login_first'.tr);
        }
        showCustomSnackBar('${apiResponse.body['message']}');
        return apiResponse;
      }
    } catch (e) {

      throw e.toString();
    }
  }




}
