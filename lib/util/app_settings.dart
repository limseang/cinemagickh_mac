import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AppSettings {
  //  >>>>>> Debug Variable <<<<<<
  static showLog(String log) => true == true ? debugPrint(log) : null;

  static const String languageEn = "en";
  static const String countryCodeEn = "US";

  // >>>>>>>>>> Bottom Navigation <<<<<<<<<
  static RxInt navigationIndex = 0.obs;

  //  >>>>>>>>>> Create History <<<<<<<<<
  static RxBool isCreateHistory = true.obs; // Use History Create or not...

  // >>>>>>>>>> Incognito Mode <<<<<<<<<
  static RxBool isIncognitoMode = false.obs;

  // >>>>>>>>>> Notification <<<<<<<<<
  static RxBool showNotification = true.obs;

  // >>>>>>>>>> Auto Play Video <<<<<<<<<
  static RxBool isAutoPlayVideo = false.obs;

  // >>>>>>>>>> Pick Profile Image <<<<<<<<<
  static RxString pickImagePath = "".obs;

  // >>>>>>>>>> Bottom Navigation <<<<<<<<<
  static RxString paymentType = "".obs;

  // >>>>>>>>>> All Page Title <<<<<<<<<
  static bool isCenterTitle = false;

  // >>>>>>>>>> Show Ads Index <<<<<<<<<

  static int showAdsIndex = 10;

  // static int showAdsIndex = 2;

  static bool isShowAds = true; // if Premium Plan Not Perches then show ads
  // static bool isShowAds = true;

  static RxString profileImage = "".obs;
  static RxString channelName = "".obs;

  static RxBool isUploading = false.obs;
  static RxBool isDownloading = false.obs;

  static RxBool isAvailableProfileData = false.obs;

  static String ipAddress = "192.168.98.99";

  // >>>>>>>>>> Fill/Edit Profile Controller <<<<<<<<<
  static TextEditingController nickNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController ageController = TextEditingController();

  static TextEditingController instagramController = TextEditingController();
  static TextEditingController facebookController = TextEditingController();
  static TextEditingController twitterController = TextEditingController();
  static TextEditingController websiteController = TextEditingController();
  static TextEditingController countryController = TextEditingController();
  static String? selectedGender;
  static TextEditingController playListNameController = TextEditingController();

  // >>>>>>>>>> Create Channel Controller <<<<<<<<<

  static TextEditingController nameController = TextEditingController(); //  Channel Name Controller => Both Use => Fill/Edit Profile And Channel Create Time
  static TextEditingController channelDescriptionController = TextEditingController();

  static String? selectedPayment;
}
