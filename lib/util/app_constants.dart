


import 'package:flutter/material.dart';
import 'package:miss_planet/data/model/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AppConstants {

  // header
  static String? bearerToken;



  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  Map<String, String> headerToken = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $bearerToken"
  };

  // String token = Get.find<AuthController>().token;
  sharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bearerToken = sharedPreferences.getString(token);
  }


  // Custom Message
  final String notLogin = 'អ្នកតម្រូវអោយ Login ជាមុនសិន \n ${'you_have_to_login_first'.tr}';
  final String noInternet = 'No Internet Connection';
  final String somethingWrong = 'Something went wrong';
  final String noData = 'No Data';
  final String noDataFound = 'No Data Found';
  final String noMoreData = 'No More Data';


  final bool isLogin = false;


  final String callback = "callbackPayment";
  static const Color appThemeColor = Color(0xFF6D67E4);


  final String appName = 'Film Library';
  final String splashIcon = 'assets/images/library.png';
  final String supportEmail = 'popcornkhmer@gmail.com';
  final String privacyPolicyUrl = 'https://github.com/P0PC0RN22/cinemagickh_privatcy/blob/main/privacy_policy.md';
  final String ourWebsiteUrl = 'https://www.library.cinemagickh.com';
  final String facebookPage = 'https://www.facebook.com/cinemagickh';
  final String iOSAppId = '1582162598';
  final String telegram = 'https://t.me/lseang';
  final String languageCode = 'language_code';
  final String countryCode = 'country_code';
  static String donateUrl = 'https://link.payway.com.kh/ABAPAY6m248535Q';
  static const String appStoreLink = 'https://apps.apple.com/kh/app/film-library/id1582162598';
  static const String playStoreLink = 'https://play.google.com/store/apps/details?id=cinemagickh.library';

  //Ads
  final String admobBannerAdUnitIdAndroid = 'ca-app-pub-7758759399095169/2887752675';
  final String admobBannerAdUnitIdiOS = 'ca-app-pub-7758759399095169/1398577034';

  final String admobRewardIOS = 'ca-app-pub-7758759399095169/1924225950';
  final String admobRewardAndroid = 'ca-app-pub-7758759399095169/3408401591';

  final String admobInterstitialAdUnitIdAndroid = 'ca-app-pub-7758759399095169/7841514692';
  final String admobInterstitialAdUnitIdiOS = 'ca-app-pub-3940256099942544/4411468910';

  static const appOpenCount = 'appOpenCount';
  static String customLoading = 'assets/animations/loading.json';

  static const String baseURL =  "https://develop.cinemagickh.com";
  static const String token = "token";
  static const String logo = 'assets/images/logo_app.png';
  static const String isSelectKey = 'is_select_key';
  static const String isSelectNumber = 'is_select_number';
  static const String deviceName = "device";
  static const String deviceToken = "device";
  static const String fmcToken = "device";
  static const String ipAddress = "device";
  static const String timeExpired = "1";
  static const String APP_VERSION = "3.0.4";
  static Color appColor = Color(0xff1DD8F1);

  static const String versionCheck = "/api/version/check";

  // auth
  static const String signIn = "/api/login";
  static const String signUp = "/api/register";
  static const String userInfo = "/api/user/info";
  static const String deviceInfo = "/api/user/login/info";
  static const String logout = "/api/logout";
  static const String deleteAccount = "/api/user/delete";
  static const String changeAvatar = "/api/user/add/avatar";
  static const String changeName = "/api/user/update/name";
  static const String loginWithSocial = "/api/login/social";
  static const String updatePhone = "/api/user/update/phone";
  static const String changePassword = "/api/user/update/password";


  // Continue To watch
  static const String ownContinue = "/api/continue-to-watch";
  static const String newContinue = "/api/continue-to-watch/create";
  static const String checkContinue = "/api/continue-to-watch/check";
  static const String detailContinue = "/api/continue-to-watch/detail/";
  static const String updateContinue = "/api/continue-to-watch/update/";
  static const String byFilm = "/api/continue-to-watch/film/";

  // Favorite
  static const String favorite = "/api/favorite/user";
  static const String favoriteList = "/api/favorite/list";
  static const String favoriteDetail = "/api/favorite/detail/";
  static const String favoriteAdd = "/api/favorite/create";
  static const String favoriteDelete = "/api/favorite/delete/";


  // Gift List
  static const String giftList = "/api/gift";
  static const String giftDetail = "/api/gift/";
  static const String giftRedeem = "/api/random/point/create";
  static const String OwnRandomHistory = "/api/random/point/user/";
  static const String OwnRandomDetail = "/api/random/point/user/";
  static const String cancelRandom = "/api/random/point/cancel/";
  static const String confirmRandom = "/api/random/point/confirm/";
  // Util API
  static const String allCategory = "/api/category";
  static const String tag = "/api/tag";
  static const String allType = "/api/type";
  static const String allCountry = "/api/country";
  static const String allCinema = "/api/available";
  static const String allArtist = "/api/artist";
  static const String artistDetail = "/api/artist/";
  static const String allArtistByFilm = "/api/film/cast/";
  static const String castDetail = "/api/film/cast/detail/";


  // Post Permission
  static const String newFilm = "/api/film/new";
  static const String newEpisode = "/api/film/episode/new/";
  static const String deleteArticle = "/api/article/delete/";
  static const String addCinemaToFilm = "/api/film/available/new";
  static const String newVideo = "/api/video/new";
  static const String newArtist = "/api/artist/new";
  static const String deleteFilm = "/api/film/delete/";
  static const String addArtistToFilm = "/api/film/cast/new";
  static const String editCast = "/api/film/cast/update/";
  static const String deleteCast = "/api/film/cast/delete/";
  static const String editArtist = "/api/artist/update/";
  static const String deleteArtist = "/api/artist/delete/";
  static const String allCinemaFilm = "/api/film/available/";
  static const String deleteCinemaFilm = "/api/film/available/delete/";
  static const String changeFilmType = "/api/film/update/type/";
  static const String editFilm = "/api/film/update";
  static const String countUser = "/api/admin/user/count";

  // Request Film
  static const String requestFilm = "/api/request/film";
  static const String requestList = "/api/request/film/all";

  // Search
  static const String search = "/api/search/all";

  //Video
  static const String video = "/api/video";

  // artical
  static const String artical = "/api/article";
  static const String articalDetail = "/api/article/detail/";
  static const String shareArticle = "https://cinemagickh.com/api/share-article";
  static const String likeArticle = "/api/like/create";

  // comment
  static const String comment = "/api/comment/create";
  static const String deleteComment = "/api/comment/delete/";


  // Film
  static const String film = "/api/film";
  static const String increaseView = "/api/film/increase/view/";
  static const String homeAPI = "/api/film/for/home";
  static const String filmDetail = "/api/film/detail";
  static const String shareFilm = "https://cinemagickh.com/api/share-film";
  static const String shotByRate = "/api/film/show/rate";
  static const String comingSoon = "/api/film/coming/soon";
  static const String addCategory = "/api/film/category/new";
  static const String deleteCategory = "/api/film/category/delete/";
  static const String genre = "/api/genre";
  static const String addGenreToFilm = "/api/film/add/genre";
  static const String watchMovieList = "/api/film/watch/movie";
  static const String searchMovie = "/api/film/search";

  // Subtitle
  static const String subtitle = "/api/subtitle";
  static const String subtitleDetail = "/api/subtitle/detail/";
  static const String subtitleByFilm = "/api/subtitle/film/";
  static const String subtitleByEpisode = "/api/episode/subtitle/episode/";

  static const String subtitleHeight = "";
  static const String subtitleSize = "";

  // rate
  static const String rate = "/api/rate/create";

  // report
  static const String createReport = "/api/report/create";


  // notification

  static const String notify = "/api/bookmark/create";
  static const String checkNotify = "/api/check/user/bookmark/";
  static const String UnNotify = "/api/bookmark/delete";

  // cinema
  static const String cinema = "/api/available";
  static const String cinemaBranch = "/api/cinema/branch";

  // payment
  static const String generatePayment = "/api/create-payment-link";
  static const String callbackPayment = "/api/webhook/payment";

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: 'assets/images/logo_english.png',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'
    ),
    LanguageModel(
        imageUrl: 'assets/images/logo_english.png',
        languageName: 'ភាសាខ្មែរ',
        countryCode: 'KH',
        languageCode: 'km'
    ),
    LanguageModel(
        imageUrl: 'assets/images/logo_china.png',
        languageName: '简体中文',
        countryCode: 'CN',
        languageCode: 'zh'
    )
  ];



}
