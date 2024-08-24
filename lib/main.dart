
import 'dart:io';
import 'dart:ui';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miss_planet/controller/localization_controller.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/screen/auth/register_screen.dart';
import 'package:miss_planet/screen/home/home_screen.dart';
import 'package:miss_planet/screen/splash_screen.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/messages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'helper/get_di.dart' as di;
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// Provides [VideoController] & [Video] etc.
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    Map<String, Map<String, String>> _languages = await di.init();
    runApp(MyApp(languages: _languages,));
    Fluttertoast.showToast(
        msg: "offline_mode".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  await Firebase.initializeApp();
  await Future.delayed(Duration(seconds: 1));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.init();
  HttpOverrides.global = MyHttpOverrides();
  Map<String, Map<String, String>> _languages = await di.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));

  await FirebaseMessaging.instance.getAPNSToken().then((value) async {
    await Firebase.initializeApp();
    runApp(MyApp(languages: _languages,));
  });

}






class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final Map<String, Map<String, String>> languages;


  MyApp({super.key,required this.languages});


  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);


  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  int _inApp = 0;
  String _authStatus = 'Unknown';
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed || state == AppLifecycleState.inactive) {
      setState(() {
        _inApp = 0;
      });
      print('resumed');
    }
    else if (state == AppLifecycleState.paused) {
      setState(() {
        _inApp = 1;
      });
      print('paused');
    }
    if (state == AppLifecycleState.detached) {
      setState(() {
        _inApp = 2;
      });
      print('detached');
    }

  }


  void initState()  {
    super.initState();

    WidgetsBinding.instance.addObserver(this);


    // NotificationService().initNotification();
    // WidgetsBinding.instance.addObserver(this);

    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   FlutterAppBadger.updateBadgeCount(1);
    //   NotificationService().showNotification(
    //       title: message.notification!.title!,
    //       body: message.notification!.body!,
    //       id: message.data['id']
    //   );
    //   // NotificationModel notification = NotificationModel(title: message.notification!.title!,body: message.notification!.body!);
    //   // ShowCustomNotification(
    //   //     title: notification.title!,
    //   //     message: message.notification!.body!,
    //   //     type: message.data['type'],
    //   //     id: message.data['id'],
    //   //     context: Get.context!);
    //
    // });
    //
    //
    // if(Platform.isAndroid){
    //   Permission.notification.request();
    // }
    // FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    // _firebaseMessage.getToken().then((token) =>{
    //   print('token $token'),
    //   Get.find<AuthController>().setFcm('$token')
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  // This widget is the root of your application.
  Widget build(BuildContext context) {


    return GetBuilder<LocalizationController>(
        builder: (localizeController) {
          return GetMaterialApp(
            title: AppConstants().appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            translations: Messages(languages: widget.languages),
            locale: localizeController.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            supportedLocales: [
              Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
              Locale(AppConstants.languages[1].languageCode!, AppConstants.languages[1].countryCode),
              Locale(AppConstants.languages[2].languageCode!, AppConstants.languages[2].countryCode),
            ],
            localeListResolutionCallback: (locales, supportedLocales) {
              for (var locale in locales!) {
                if (supportedLocales.contains(locale)) {
                  return locale;
                }
              }
              return supportedLocales.first;
            },
            fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
            home: SplashScreen(),
          );
        }
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


