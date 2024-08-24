import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/data/model/userModel.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/screen/film/coming_soon_screen.dart';
import 'package:miss_planet/screen/home/search_screen.dart';
import 'package:miss_planet/screen/video/continue_normal_video.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:miss_planet/util/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
class homeScreen extends StatefulWidget {
  UserModel? userModel;
  homeScreen({super.key, this.userModel});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool _isLoading = false;
  bool _isLogin = false;
  int _currentIndex = 0;
  int _selectedIndex = 0;
  bool _itemLoading = false;
  AuthController authController = Get.find<AuthController>();
  FilmController filmController = Get.find<FilmController>();

  init() async {
    setState(() {
      _isLoading = true;
    });
   if(authController.isLogin == true) {
     await authController.ownContinue();
     setState(() {
       _isLogin = true;
     });
    }
   else {
     setState(() {
       _isLogin = false;
     });
    }
    await filmController.getHomeApi();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }
  Widget build(BuildContext context) {
    return CustomScaffold(body: _isLoading == true ? Center(child: buildLoading()) : buildBody());
  }
  buildBody() {
    return GetBuilder<AuthController>(
      builder: (auth) {
        var user = widget.userModel?.data;
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.PADDING_SIZE_Thirty_Five,
                ),
                InkWell(
                  onTap: () {
                    auth.isNotLogin == true ? nextScreen(context, LoginScreen()) : nextScreen(context, homeScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 12.0),
                              child: Container(
                                width: 50,
                                height: 60,
                                child:
                                auth.isNotLogin == true ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('${AppConstants.logo}'),
                                ) : Container(
                                  width: 50,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              user?.avatar ?? ''),
                                          fit: BoxFit.cover)),

                                )
                              ),
                            ),

                          ],
                        ),

                       Padding(
                         padding: const EdgeInsets.only(bottom: 8.0),
                         child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             auth.isNotLogin == true ? customRegularTextStyle(text: 'hello'.tr, fontSize: 20, color: Colors.white, )
                                 :    customRegularTextStyle(text: '${'hello'.tr} ${user?.name?.contains('@') == true ? user?.name?.split('@').first : user?.name}'.tr, fontSize: 24,),
                              SizedBox(height: 5,),
                              auth.isNotLogin == true ? customRegularTextStyle(text: 'login_to_see_point'.tr, fontSize: 14, color: Colors.grey,)
                                  : Row(
                                children: [
                                  customRegularTextStyle(text: '${'your_point:'.tr} ${user?.point}',fontSize: 15),
                                  SizedBox(width: 5,),
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.grey,
                                    size: 20,
                                  )
                                ],
                              ),
                           ],
                         ),
                       )


                        // Container(
                        //   alignment: Alignment.center,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       color: ColorResources.defaultBackgroundGrey,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Padding(
                        //         padding: const EdgeInsets.only(left: 20.0, right: 20),
                        //         child: InkWell(
                        //           onTap: (){
                        //             auth.isNotLogin == true ?nextScreen(context, LoginScreen()) : nextScreen(context, homeScreen());
                        //           },
                        //           child: Row(
                        //             children: [
                        //                                          auth.isNotLogin == true ?customBoldTextStyle(
                        //              text: 'tap_to_login'.tr,
                        //              fontSize: 14
                        //                                          ) : customBoldTextStyle(text: '${'your_point:'.tr} ${user?.point}',fontSize: 15),
                        //           SizedBox(width: 5,),
                        //           Icon(
                        //             Icons.info_outline,
                        //             color: Colors.grey,
                        //             size: 20,
                        //           )
                        //                                       ],
                        //                                     ),
                        //         ),
                        //       ),
                        // ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  onTap: () {
                    nextScreen(context, SearchScreen());
                  },
                  child: Container(
                    width: Get.width * 0.94,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          customRegularTextStyle(text: 'search'.tr, fontSize: 18, color: Colors.grey,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: Get.height * 0.35, // Set the desired height
                    autoPlay: true, // Enable auto-scrolling
                    autoPlayInterval: Duration(seconds: 10), // Time between slides
                    autoPlayAnimationDuration: Duration(milliseconds: 1000), // Animation duration
                    autoPlayCurve: Curves.fastOutSlowIn, // Curve for the animation
                    enlargeCenterPage: true, // Make the center item larger
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: Get.height * 0.2, // Adjust this height if necessary
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: _currentIndex == i - 1
                                ? [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              ),
                            ]
                                : [],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo_app.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: 40,
                ),
                Container(
                  width: Get.width,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // nextScreen(context, PIPExampleApp());
                            // nextScreen(context, AllArtistScreen());
                          },
                          child: material_App.CustomIconButtom(
                            title: 'actors'.tr,
                            onPressed: () {},
                            icon: 'assets/icon/home/actor.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // nextScreen(context, topRateScreen());
                          },
                          child: material_App.CustomIconButtom(
                              title: 'top_rates'.tr,
                              onPressed: () {},
                              icon: 'assets/icon/home/top.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          // onTap: () async {
                          //   //ask for permission to use location
                          //   LocationPermission permission = await Geolocator.checkPermission();
                          //   if (permission == LocationPermission.denied) {
                          //     permission = await Geolocator.requestPermission();
                          //   }
                          //   else if (permission == LocationPermission.deniedForever) {
                          //     await Geolocator.openAppSettings();
                          //   }
                          //   else if (permission == LocationPermission.whileInUse ||
                          //       permission == LocationPermission.always)
                          //   {
                          //     nextScreen(context, CinemaScreen());
                          //     print(permission);
                          //   }
                          //   else {
                          //     showCustomSnackBar('no_permission'.tr, context);
                          //   }
                          //   nextScreen(context, CinemaScreen());
                          //
                          //
                          // },
                          child: material_App.CustomIconButtom(
                              title: 'cinemas'.tr,
                              onPressed: () {},
                              icon: 'assets/icon/home/cinema.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // nextScreen(context, watchScreen());
                          },
                          child: material_App.CustomIconButtom(
                              title: 'watches'.tr,
                              onPressed: () {},
                              icon: 'assets/icon/home/watching.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showCustomDialog('coming_soon'.tr, context);
                            Get.find<FilmController>().comingSoon();
                          },
                          child: material_App.CustomIconButtom(
                              title: 'exclusive'.tr,
                              onPressed: () {},
                              icon: 'assets/icon/home/excluseive.png'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.only(left: 40),
                    alignment: Alignment.centerLeft,
                    child: customBoldTextStyle(text: 'now_showing'.tr, fontSize: 18,fontSize2: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: buildHomeItem(item: filmController.homeListModel.data?.nowShowing??[]),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(left: 40),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            customBoldTextStyle(text: 'coming_soon', fontSize: 18,fontSize2: 18),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  nextScreen(context, ComingSoonScreen());
                                },
                                child: customRegularTextStyle(text: 'see_more'.tr, fontSize: 14, color: Colors.grey,)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ))),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: buildHomeItem(item: filmController.homeListModel.data!.comingSoon!),
                ),
                SizedBox(height: 20,),
                Container(
                    padding: EdgeInsets.only(left: 40),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        customBoldTextStyle(text: 'film_news', fontSize: 18,fontSize2: 18),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              // nextScreen(context, AllArticleScreen());
                            },
                            child: customRegularTextStyle(text: 'see_more'.tr, fontSize: 14, color: Colors.grey,)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: buildHomeItem(
                      isNews: true,
                      item: filmController.homeListModel.data!.articles!),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(left: 40, right: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        customBoldTextStyle(text: 'most_watched', fontSize: 18,fontSize2: 18),
                        InkWell(
                            onTap: () {
                              // nextScreen(context, watchScreen());
                            },
                            child: customRegularTextStyle(text: 'see_more'.tr, fontSize: 14, color: Colors.grey,)),
                      ],
                    )),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: buildHomeItem(item: filmController.homeListModel.data!.mostWatch!),

                ),
                auth.isNotLogin != true ?  authController.continueToWatchModel?.data!.length != 0  ? Column(
                  children: [
                    SizedBox(height: 40,),
                    Container(
                        padding: EdgeInsets.only(left: 40, right: 20),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            customBoldTextStyle(text: 'continue_watching', fontSize: 18,fontSize2: 18),
                            // InkWell(
                            //     onTap: () {
                            //       nextScreen(context, watchScreen());
                            //     },
                            //     child: customRegularTextStyle(text: 'see_more'.tr, fontSize: 14, color: Colors.grey,)),
                          ],
                        )),
                    SizedBox(height: 20,),
                    authController.continueToWatchModel?.data != null ?  GetBuilder<AuthController>(
                        builder: (controller) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: Get.width,
                              height: 160,
                              child: ListView.builder(
                                itemCount: controller.continueToWatchModel!.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var film = controller.continueToWatchModel!.data![index];
                                  return GestureDetector(
                                    onTap: ()async {
                                      setState(() {
                                        _itemLoading = true;
                                        _selectedIndex = index;
                                      });
                                      authController.detailContinue(id: film.id.toString()).then((value) async {
                                        if(value == true){

                                          // await SystemChrome.setPreferredOrientations([
                                          //   DeviceOrientation.landscapeLeft,
                                          //   DeviceOrientation.landscapeRight,
                                          // ]);
                                          // Future.delayed(Duration(milliseconds: 500)).then((_) {
                                          //    setState(() {
                                          //
                                          //    });
                                          //
                                          // });

                                          print('url ${controller.continueToWatchModel!.data![index].film_id}');
                                          await authController.setFilmURL(Get.find<AuthController>().detailContinueModel!.data!.url.toString());
                                          await authController.setEpisodeNumber('${Get.find<AuthController>().detailContinueModel!.data!.episodes}');
                                          await authController.setFilmID('${film.id.toString()}');
                                          await  authController.setStartTime('${Get.find<AuthController>().detailContinueModel!.data!.progressing ?? '0'}');
                                          await  authController.setEpisodeID('${Get.find<AuthController>().detailContinueModel!.data!.episodeId}');
                                          await authController.setContinueID('${Get.find<AuthController>().detailContinueModel!.data!.id}');
                                          await  Get.find<FilmController>().getSubtitle(id: int.parse(Get.find<AuthController>().detailContinueModel!.data!.episodeId!)).then((value) async {
                                            if(value == 'ok'){
                                              if(filmController.subtitleModel?.data!.length != 0){
                                                //find subtitle
                                                for(int i = 0; i < filmController.subtitleModel!.data!.length; i++){
                                                  if(filmController.subtitleModel!.data![i].languageCode == Localizations.localeOf(context).countryCode){
                                                    await authController.setSubtitleURL(filmController.subtitleModel!.data![i].url!);
                                                    await authController.setSubtitleIndex(i);
                                                    break;
                                                  }
                                                  else {
                                                    await authController
                                                        .setSubtitleURL(
                                                        filmController.subtitleModel!.data![0].url!);
                                                  }
                                                }
                                              }
                                              else {
                                                await authController
                                                    .setSubtitleURL('');
                                              }
                                            }
                                          });

                                          if(authController.episodeID == null){

                                            Get.find<FilmController>().getSubtitle(id: int.parse(authController.episodeID!)).then((value) {
                                              if(value == 'ok'){
                                                if( Get.find<FilmController>().subtitleModel?.data!.length != 0){
                                                  print('language device ${AppConstants.languages}');

                                                }
                                              }
                                            });
                                          }

                                          // InterstitialAds().createInterstitialAd();
                                          Future.delayed(Duration(milliseconds: 500)).then((_) {
                                            nextScreen(context, ContinueVideo(
                                              images: film.poster ?? '',
                                              filmId: '${controller.continueToWatchModel!.data![index].film_id}',
                                              id: '${Get.find<AuthController>().detailContinueModel!.data!.id}' ,
                                              url: Get.find<AuthController>().detailContinueModel!.data!.url ?? '',
                                              startTime: '${Get.find<AuthController>().detailContinueModel!.data!.progressing ?? '0'}',
                                              index: index,

                                            ));

                                          });
                                          setState(() {
                                            _itemLoading = false;
                                          });
                                        }
                                        else {
                                          showCustomSnackBar('something_wrong'.tr);
                                          setState(() {
                                            _itemLoading = false;
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child:_itemLoading == true && _selectedIndex == index ?
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.grey.withOpacity(0.5),
                                        child: Container(
                                          width: 100,

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey),
                                        ),
                                      )
                                          :  Container(
                                        width: 100,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: CachedNetworkImageProvider(film.poster!),
                                                fit: BoxFit.cover)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [

                                            authController.continueToWatchModel?.data?[index].subtitle == true ? Container(
                                                width: 150,

                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Icon(Icons.closed_caption,color: Colors.white,size: 24,),
                                                )) : SizedBox(),
                                            Stack(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(10)),

                                                ),
                                                Container(
                                                  width: film.progressing == null ? 0:  (double.parse(film.progressing.toString()) * 150) / (double.parse(film.duration.toString())),
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(10)),

                                                ),

                                              ],
                                            ),

                                            Container(
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: customRegularTextStyle(
                                                      text: '${'Episode'.tr}: ${film.episodes}',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    ) : SizedBox(),
                  ],
                ) : SizedBox() : SizedBox(),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
