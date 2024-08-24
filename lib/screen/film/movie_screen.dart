import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/screen/video/continue_normal_video.dart';
import 'package:miss_planet/util/alert_dialog.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/custom_HTML.dart';
import 'package:miss_planet/util/custom_image.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:miss_planet/util/style.dart';
import 'package:pod_player/pod_player.dart';
import 'package:share_plus/share_plus.dart';

class MovieScreen extends StatefulWidget {
  final String? poster;
  final int id;
  final bool? isEpisode;

  const MovieScreen({
    Key? key,
    this.poster,
    required this.id,
    this.isEpisode,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final FilmController filmController = Get.find<FilmController>();
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController _commentController = TextEditingController();

  late final PodPlayerController trailerController;
  bool _isLoading = false;
  bool _isAdmin = false;
  bool _isPlayTrailer = false;
  bool _shareLoading = false;
  double _ratingStar = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _loadFilmDetails();
  }

  Future<void> _loadFilmDetails() async {
    setState(() {
      _isLoading = true;
    });

    final result = await filmController.filmDetail(id: widget.id);
    if (result == 'OK') {
      trailerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          filmController.movieDetailModel.data?.trailer ?? '',
        ),
        podPlayerConfig: PodPlayerConfig(
          autoPlay: true,
          videoQualityPriority: [1080, 720, 480, 360], // Ensure higher qualities are prioritized first
        ),
      )..initialise();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    trailerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            _isPlayTrailer ? _buildTrailerView() : _buildMovieDetailsView(),
            SizedBox(height: 40),
            _buildFilmDescription(),

            _buildCommentSection(),
            SizedBox(height: 40),
            _buildCommentsList(),
            SizedBox(height: 40),
            _buildAdminControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilmDescription() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customBoldTextStyle(text: 'description'.tr, fontSize: 20, color: Colors.white),
              SizedBox(height: 10),
              HtmlBodyWidget(
                content: filmController.movieDetailModel.data?.overview ?? '',
                color: Colors.white,
                isIframeVideoEnabled: false,
                isVideoEnabled: false,
                isimageEnabled: true,
                fontSize: 12,

              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailerView() {
    return SafeArea(
      child: Column(
        children: [
          _buildMainAppBar(title: 'Trailer Mode',color: Colors.white),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PodVideoPlayer(controller: trailerController),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _isPlayTrailer = !_isPlayTrailer;
                trailerController.pause();
              });
            },
            child: Container(
              width: Get.width * 0.6,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Exit Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieDetailsView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () {
            // Handle tap event to show full image
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.poster ?? filmController.movieDetailModel.data?.cover ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: Get.height * 0.1,
          left: 20,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 10,
          child: _buildMovieInfoCard(),
        ),

      ],
    );
  }

  Widget _buildMovieInfoCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailInfoSection(),
        SizedBox(width: 40),
        _buildRatingSection(),
      ],
    );
  }

  Widget _buildDetailInfoSection() {
    return Container(
      width: Get.width * 0.45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildInfoRow('title'.tr, '${filmController.movieDetailModel.data?.title!.split('(')[0] ?? ''}'), // Placeholder title
              _buildInfoRow('Eng Title', '${filmController.movieDetailModel.data!.title!.split('(')[1].split(')')[0] ?? ''}'), // Placeholder original title
              _buildInfoRow('category'.tr, 'Drama'), // Placeholder category
              _buildInfoRow('release_date'.tr, filmController.movieDetailModel.data?.releaseDate ?? ''), // Placeholder date
              _buildInfoRow('running_time'.tr, '120 min'), // Placeholder running time
              _buildInfoRow('language'.tr, filmController.movieDetailModel.data?.language ?? ''),
              _buildInfoRow('genre'.tr, filmController.movieDetailModel.data?.genre?.description ?? ''),
              _buildInfoRow('distributor'.tr, filmController.movieDetailModel.data?.distributors ?? ''),

            ],
          ),
          Positioned(
              top: 80,
              right: filmController.movieDetailModel.data!.available!.isEmpty || filmController.movieDetailModel.data?.available?[0].available == 'App'
                  ? 4
                  : 6,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  filmController.movieDetailModel.data?.available?.length != 0 ?    InkWell(
                      child: filmController.movieDetailModel.data?.available?[0].available == 'App'
                          ? SizedBox()
                          : GestureDetector(
                        onTap: () async {
                          // authController.userModel.data?.roleId == "1" || authController.userModel.data?.roleId == "2"
                          //     ? nextScreen(context, addCinemaToFilm(filmID: filmController.movieDetailModel.data!.id!,))
                          //     : SizedBox();
                        },
                        child:
                        customBoldTextStyle(text: 'available_in', fontSize: 16 ,),
                      )):authController.userModel?.data?.roleId == 1 || authController.userModel?.data?.roleId == 2
                      ?InkWell(
                      child:GestureDetector(
                        onTap: () async {
                          // nextScreen(context, addCinemaToFilm(filmID: filmController.movieDetailModel.data!.id!,));
                        },
                        child:  customBoldTextStyle(text: 'add_cinemas', fontSize: 20,),
                      )):SizedBox(),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 125,
                      height: 100,
                      child: ListView.builder(
                        //show only 3 available
                          itemCount: filmController.movieDetailModel.data!.available!.length > 3 ? 3 : filmController.movieDetailModel.data?.available?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('device language : ${Localizations.localeOf(context).countryCode}');
                                if (filmController.movieDetailModel.data?.available?[index].available == 'App') {
                                  if (filmController.movieDetailModel.data?.episode?.length != 0) {

                                    if(authController.isNotLogin){
                                      showCustomSnackBar('you_have_to_login_first'.tr);
                                    }
                                    else {
                                      print('episode : ${filmController.movieDetailModel.data?.id?.toString()}');
                                      authController.byFilm(film_id: filmController.movieDetailModel.data!.id!.toString()).then((value)async {
                                        if(value == 'ok'){
                                          await SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.landscapeLeft,
                                            DeviceOrientation.landscapeRight,
                                          ]);

                                          await  authController.setEpisodeNumber('1');
                                          await  authController.setFilmURL(authController.continueByFilmModel!.data!.episodes![0].file!);
                                          await authController.setFilmID(filmController.movieDetailModel.data!.id!.toString());
                                          await authController.setStartTime(authController.continueByFilmModel!.data!.episodes![0].progressing ?? '0');
                                          await authController.setContinueID('${authController.continueByFilmModel!.data!.episodes![0].continueId ?? '0'}');
                                          await authController.setEpisodeID('${authController.continueByFilmModel!.data!.episodes![0].id ?? '0'}');
                                          await Get.find<FilmController>().getSubtitle(id: authController.continueByFilmModel!.data!.episodes![0].id ?? 0).then((_) async {
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
                                            else{
                                              await authController.setSubtitleURL('');
                                            }
                                          });
                                          nextScreen(context, ContinueVideo(
                                            images: filmController.movieDetailModel.data!.poster ?? '' ,
                                            filmId: '${filmController.movieDetailModel.data!.id}',
                                            id: '${authController.continueByFilmModel!.data!.episodes![0].id ?? '0'}' ,
                                            url: authController.continueByFilmModel!.data!.episodes![0].file!,
                                            startTime: '${authController.continueByFilmModel!.data!.episodes![0].progressing ?? '0'}',
                                            index: index,

                                          ));


                                        }
                                      });
                                    }

                                  } else {
                                    print('episode : ${filmController.movieDetailModel.data?.episode?.length}');
                                    showCustomDialog('please_wait_we_are_uploading_new_episode_soon', context);
                                  }
                                } else {
                                  if (filmController
                                      .movieDetailModel.data?.available?[index].available == 'Legend') {
                                    // nextScreen(context, CinemaScreen(index: 0,));
                                  } else if (filmController.movieDetailModel.data?.available?[index].available == 'Prime') {
                                    // nextScreen(context, CinemaScreen(index: 1,));
                                  } else {
                                    // nextScreen(context, CinemaScreen(index: 2,));
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: filmController.movieDetailModel.data!.available![index] != 1 ? 8.0 : 0),
                                child: Column(
                                  children: [filmController.movieDetailModel.data?.available?[index].available != 'App' ? Container(
                                    width: 30,
                                    height: 30,
                                    child:
                                    CustomCacheImage(
                                      imageUrl: filmController.movieDetailModel.data!.available![index].logo!,
                                      radius: 4,
                                      film: false,
                                      news: true,
                                      type: '',
                                      rate: '0',
                                    ),
                                  )
                                      : Padding(
                                    padding:
                                    const EdgeInsets.only(right: 20, top: 30),
                                    child:
                                    Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white),
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(right: 6.0, left: 4),
                                          child:
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.play_arrow,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              customBoldTextStyle(text: 'watch_now', fontSize: 12, color: Colors.black),
                                            ],
                                          ),
                                        )),
                                  ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          customBoldTextStyle(text: '$label :', fontSize: 14, color: Colors.black),
          SizedBox(width: 20),
          customRegularTextStyle(text: value, fontSize: 14, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      width: Get.width * 0.45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRatingBox(),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRateThisButton(),
              SizedBox(width: 20),
              _buildTrailerButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRatingBox() {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '${filmController.movieDetailModel.data?.rating ?? '0'}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Icon(
              Icons.star,
              color: index < (double.parse(filmController.movieDetailModel.data?.rating ?? '0')) / 2
                  ? Colors.yellow
                  : Colors.white.withOpacity(0.5),
              size: 20,
            );
          }),
        ),
        SizedBox(height: 10),
        customBoldTextStyle(
          text: 'rating_by'.tr + ' ${filmController.movieDetailModel.data?.ratePeople ?? '0'} ' + 'users'.tr,
          fontSize: 14,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildRateThisButton() {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            context: context,
            builder: (context) {
              return buildButtonSheet(
                title: 'rate_this_Film',
              );
            });
      },
      onLongPress: () {
        if (authController.userModel?.data?.roleId == 1 || authController.userModel?.data?.roleId == 2) {
          setState(() {
            _isAdmin = !_isAdmin;
          });
        }
      },
      child: Container(
        height: 35,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            _isAdmin ? 'Admin Mode' : 'rate_this'.tr,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailerButton() {
    return GestureDetector(
      onTap: () {
        if(filmController.movieDetailModel.data!.trailer!.contains('youtube') || filmController.movieDetailModel.data!.trailer!.contains('youtu.be')){
          setState(() {
            _isPlayTrailer = !_isPlayTrailer;
          });
        }else{
          showCustomDialog('this_film_not_has_trailer_yet', context);
        }
      },
      child: Container(
        height: 35,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow, color: Colors.black),
              SizedBox(width: 5),
              Text(
                'trailer'.tr,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentSection() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20,),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:  customBoldTextStyle(text: 'comment'.tr, fontSize: 20, color: Colors.white),
          ),

          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:  customBoldTextStyle(
              text: 'if_you_choose_anonymous_your_profile_will_not_show'.tr,
              fontSize: 10,
              color: Colors.red,
            ),

          ),
          SizedBox(height: 20),
          Container(
            width: Get.width,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: TextField(
                      controller: _commentController,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'input_your_comment'.tr,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16), // More padding for readability
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      filmController.setIsLoding(true);
                    });
                    print(authController.userModel?.data?.roleId);
                    await Get.find<AuthController>().isNotLogin == true  ?   showCustomDialog('${AppConstants().notLogin}', Get.context!,isError: true,onPressed: (){
                      nextScreenReplace(Get.context!, LoginScreen());
                    },hasOnpressed: true) : CustomCmtDialog.showCustomCupertinoActionSheet(context,
                        userAvatar: Get.find<AuthController>().userModel!.data!.avatar.toString(),
                        userName: Get.find<AuthController>().userModel!.data!.name.toString(),
                        content: _commentController.text,
                        id: filmController.movieDetailModel.data!.id!, type: 2);
                    setState(() {
                      _commentController.text = '';
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8,right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () async {
                        setState(() {
                          filmController.setIsLoding(true);
                        });
                        print(authController.userModel?.data?.roleId);
                        await authController.isNotLogin == true  ?   showCustomDialog('${AppConstants().notLogin}', Get.context!,isError: true,onPressed: (){
                          nextScreenReplace(Get.context!, LoginScreen());
                        },hasOnpressed: true) : CustomCmtDialog.showCustomCupertinoActionSheet(context,
                            userAvatar: authController.userModel!.data!.avatar.toString(),
                            userName: authController.userModel!.data!.name.toString(),
                            content: _commentController.text,
                            id: filmController.movieDetailModel.data!.id!, type: 2);
                        setState(() {
                          _commentController.text = '';
                          FocusScope.of(context).unfocus();
                        });
                        // Your send action here
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList() {
    return GetBuilder<FilmController>(builder: (controller) {
      final comments = controller.movieDetailModel.data?.comment ?? [];

      return ListView.builder(
        itemCount: comments.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final comment = comments[index];

          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Container(

              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: comment.avatar ?? 'https://cinemagic.oss-ap-southeast-1.aliyuncs.com/Artist/17389d1be538316abb44714099d1aca0.jpg?OSSAccessKeyId=LTAI5tE3dUVa8vcQwYcDZJgV&Expires=1724435364&Signature=T1wI8cizsGs6m5kdmU5N9j%2B32pk%3D',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      width: 50,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/image/logo_app.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            customRegularTextStyle(
                              text: comment.user?.capitalizeFirst ?? '',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            if (comment.rate != null) ...[
                              SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow, size: 14),
                                      SizedBox(width: 5),
                                      customBoldTextStyle(
                                        text: '${comment.rate}',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 10),
                        customRegularTextStyle(
                          text: comment.comment ?? '',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  if (comment.userId == authController.userModel?.data?.id.toString())
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        // Delete comment logic
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Icon(Icons.delete, color: Colors.white, size: 20),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAdminControls() {
    return _isAdmin
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildAdminControlButton('Delete', Colors.red, () {
              // Handle delete logic
            }),
            _buildAdminControlButton('Add Cast', Colors.red, () {
              // Handle add cast logic
            }),
            _buildAdminControlButton('Cinema', Colors.red, () {
              // Handle cinema logic
            }),
            _buildAdminControlButton('Cast', Colors.red, () {
              // Handle cast logic
            }),
            _buildAdminControlButton('Type', Colors.red, () {
              // Handle type logic
            }),
          ],
        ),
      ),
    )
        : SizedBox();
  }

  Widget _buildAdminControlButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: customBoldTextStyle(
            text: label,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMainAppBar({required String title, Color? color}) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(color: color?? Colors.black, fontSize: 18),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  buildButtonSheet({required String title}) {
    return Container(
      width: Get.width * 0.8,
      height: 250,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                customBoldTextStyle(text: title, fontSize: 18, color: Colors.black),
                SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                    itemCount: 10,
                    glowColor: Colors.white,
                    initialRating: _ratingStar,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 30,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) async {
                      await filmController.setRating(rating);
                      setState(() {
                        _ratingStar = filmController.rating;
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                customBoldTextStyle(text: '${'your_rating'.tr} : ${filmController.rating}', fontSize: 18, color: Colors.black),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    filmController.rateFilm(
                        id: filmController.movieDetailModel.data!.id!,
                        rating: _ratingStar.toString());
                    Get.back();
                  },
                  child: Container(
                    width: Get.width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: Center(
                        child: customBoldTextStyle(text: 'submit_your_rate', fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            );
          }),
    );
  }
}