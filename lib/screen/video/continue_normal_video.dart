import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/util/app_settings.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/style.dart';



import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';



class ContinueVideo extends StatefulWidget {
  final String url;
  final String startTime;
  final String id;
  final String filmId;
  final String images;
  bool? isChangeVideo;
   ContinueVideo({super.key, required this.index, required this.url, required this.startTime, required this.id, required this.filmId,required this.images, this.isChangeVideo = false});

  final int index;

  @override
  State<ContinueVideo> createState() => _ContinueVideoState();
}

class _ContinueVideoState extends State<ContinueVideo>  with SingleTickerProviderStateMixin {
  late VideoPlayerController videoPlayerController;
  FilmController filmController = Get.find<FilmController>();
  AuthController authController = Get.find<AuthController>();
  late Animation<Color?> _colorAnimation;
  late Animation<double> _scaleAnimation;
  late AnimationController _controller;
  late Animation<double> _animation;
  ChewieController? chewieController;
  static const platform = MethodChannel('cinemagickh.news/headset');
  String _status = 'Unknown';
  RxInt videoPosition = 0.obs;
  bool? isShowControl = false;
  bool apiCalledDuringPause = false;
  bool apiCalledDuringPause2 = false;
  String? newUrl;
  bool _isLoading = false;
  bool _changeVideo = false;
  bool _showNextEpisode = false;
  bool _isHovered = false;
  double _progress = 0.0;
  bool _fitScreen = false;
  bool _customSubSize = false;


  final SubtitleController subtitleController = SubtitleController(
    subtitleUrl: "${Get.find<AuthController>().subtitleURL}",
    subtitleType: SubtitleType.srt,
    showSubtitles: true,
    // subtitleDecoder: SubtitleDecoder.utf8,


  );

  Future<void> _checkHeadsetStatus() async {
    try {
      final bool result = await platform.invokeMethod('isHeadsetConnected');
      setState(() {
        _status = result ? 'Headset Connected' : 'No Headset Connected';
        print('Headset Status: $_status');
      });
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Failed to get status: ${e.message}';
        print('Headset Status: $_status');
      });
    }
  }

  Future<void> initializeVideoPlayer(String videoUrl) async {
    print('filmID ${widget.filmId}');
   await Get.find<AuthController>().byFilm(film_id: widget.filmId);
    await Get.find<FilmController>().getSubtitle(id:
    int.parse(Get.find<AuthController>().episodeID!));
    print('video url ${Get.find<AuthController>().filmURL}');
  await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // 500.milliseconds.delay();

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(Get.find<AuthController>().filmURL!));
    print('video url pel jol ${Get.find<AuthController>().filmURL}');
    try {
      await videoPlayerController.initialize();
      chewieController = ChewieController(

        videoPlayerController: videoPlayerController,
        startAt: Duration(seconds: int.parse(widget.startTime)),
        autoPlay: true,
        looping: false,
        allowedScreenSleep: false,
        allowMuting: false,
        showControlsOnInitialize: false,
        showControls: false,
      );
      if (videoPlayerController.value.isInitialized) {
        setState(() {
        });
      }

      videoPlayerController.addListener(() async {
        if(videoPlayerController.value.duration == videoPlayerController.value.position){
          _checkHeadsetStatus();
          var video = Get.find<AuthController>();
         if(!_changeVideo){
           Get.find<AuthController>().checkContinue(
               film_id: widget.filmId,
               episode_id: video.episodeID!,
               processing: videoPlayerController.value.position.inSeconds.toString()
           ).then((value) {
             if(value != 'ok'){
               Get.find<AuthController>().newContinue(
                   film_id: widget.filmId,
                   duration: videoPlayerController.value.duration.inSeconds.toString(),
                   film_type: "episode",
                   episodeNumber: video.episodeNumber ?? '1',
                   episode_id: video.episodeID!,
                   progressing: videoPlayerController.value.position.inSeconds.toString(),
                   watched_at: DateTime.now().toString());
             }
           });

         }
         }
        if( videoPlayerController.value.isPlaying == false){
          if (!apiCalledDuringPause && !_changeVideo) {
            apiCalledDuringPause = true;
            print('continuess id ${Get.find<AuthController>().continueID}');
            var video = Get.find<AuthController>();
            Get.find<AuthController>().newContinue(
                film_id: widget.filmId,
                duration: videoPlayerController.value.duration.inSeconds.toString(),
                film_type: "episode",
                episodeNumber: video.episodeNumber ?? '1',
                episode_id: video.episodeID!,
                progressing: videoPlayerController.value.position.inSeconds.toString(),
                watched_at: DateTime.now().toString());
          }
        } else {
          apiCalledDuringPause = false;

        }
        if (videoPlayerController.value.isInitialized) {
          _progress = (videoPlayerController.value.position.inSeconds * 100) / videoPlayerController.value.duration.inSeconds;
          videoPosition.value = videoPlayerController.value.position.inMilliseconds;
          if (AppSettings.isAutoPlayVideo.value && videoPlayerController.value.position >= videoPlayerController.value.duration) {
            videoPlayerController.pause();
           Get.find<AuthController>().checkContinue(
                film_id: widget.filmId,
                episode_id: Get.find<AuthController>().episodeID!,
                processing: videoPlayerController.value.position.inSeconds.toString()
            ).then((value) {
              if(value != 'ok'){
                Get.find<AuthController>().newContinue(
                    film_id: widget.filmId,
                    duration: videoPlayerController.value.duration.inSeconds.toString(),
                    film_type: "episode",
                    episodeNumber: Get.find<AuthController>().episodeNumber!,
                    episode_id: Get.find<AuthController>().episodeID!,
                    progressing: videoPlayerController.value.position.inSeconds.toString(),
                    watched_at: DateTime.now().toString());
              }
            });

          }
          if (videoPlayerController.value.isBuffering) {
          } else {}
        }
      });
      autoNextEpisode();
    } catch (e) {
      chewieController?.dispose();
      AppSettings.showLog("Video Loading Failed");
      await initializeVideoPlayer(videoUrl);
    }
  }



  Future<void> onRotate(double aspectRatio) async {
    chewieController = null;
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: aspectRatio,

      looping: true,
      allowedScreenSleep: false,
      allowMuting: false,
      showControlsOnInitialize: false,
      showControls: false,
    );
    setState(() {});
  }



  Future<void> forwardSkipVideo() async {
    await videoPlayerController.seekTo((await videoPlayerController.position)! + const Duration(seconds: 10));
  }

  Future<void> backwardSkipVideo() async {
    await videoPlayerController.seekTo((await videoPlayerController.position)! - const Duration(seconds: 10));
  }



  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        videoPlayerController.play();
        break;
      case AppLifecycleState.inactive:
        Get.find<AuthController>().updateContinue(
          filmID: widget.filmId,
          id: Get.find<AuthController>().continueID ?? widget.id,
          progressing: videoPlayerController.value.position.inSeconds.toString(),
          watchAt: DateTime.now().toString(),
        );
        break;
      case AppLifecycleState.paused:
        Get.find<AuthController>().updateContinue(
          filmID: widget.filmId,
          id: Get.find<AuthController>().continueID ?? widget.id,
          progressing: videoPlayerController.value.position.inSeconds.toString(),
          watchAt: DateTime.now().toString(),
        );
        break;
      case AppLifecycleState.detached:
        Get.find<AuthController>().updateContinue(
          filmID: widget.filmId,
          id: Get.find<AuthController>().continueID ?? widget.id,
          progressing: videoPlayerController.value.position.inSeconds.toString(),
          watchAt: DateTime.now().toString(),
        );
        break;
      case AppLifecycleState.hidden:
        Get.find<AuthController>().updateContinue(
          filmID: widget.filmId,
          id: Get.find<AuthController>().continueID ?? widget.id,
          progressing: videoPlayerController.value.position.inSeconds.toString(),
          watchAt: DateTime.now().toString(),
        );
        break;
    }
  }
  bool isAirPlayConnected = false;


  void changeVideo() async {
    if(_isLoading == true){
      return;
    }
    setState(() {
      _isLoading = true;
    });



    videoPlayerController.removeListener(() {});

    videoPlayerController.pause();
    print('video url ${Get.find<AuthController>().filmURL}');


    videoPlayerController = VideoPlayerController.network(Get.find<AuthController>().filmURL!);


    await videoPlayerController.initialize();

    chewieController?.dispose();


    int startTime = 0;
    try {
      startTime = int.parse(Get.find<AuthController>().startTime ?? '0');
    } catch (e) {
      print('Error parsing startTime: $e');
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      startAt: Duration(seconds: startTime),
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      allowMuting: false,
      showControlsOnInitialize: false,
      showControls: false,
    );
    if (videoPlayerController.value.isInitialized) {
      setState(() {
        _isLoading = false;
      });
    }
    await  Get.find<FilmController>().getSubtitle(id: int.parse(authController.episodeID ?? '')).then((value) async {
      if(value == 'ok'){

        if(filmController.subtitleModel?.data!.length != 0){
          //find subtitle
          for(int i = 0; i < filmController.subtitleModel!.data!.length; i++){
            if(filmController.subtitleModel!.data![i].languageCode == Localizations.localeOf(context).countryCode){
              subtitleController.updateSubtitleUrl(url: filmController.subtitleModel!.data![i].url!);
              await authController.setSubtitleURL(filmController.subtitleModel!.data![i].url!);
              await authController.setSubtitleIndex(i);
              break;
            }
            else {
              subtitleController.updateSubtitleUrl(url: filmController.subtitleModel!.data![0].url!);
              await authController.setSubtitleURL(filmController.subtitleModel!.data![0].url!);
            }
          }
        }
        else {
          await authController.setSubtitleURL('');
          subtitleController.updateSubtitleUrl(url: '');
        }
      }
    });
    Get.find<AuthController>().setContinueID(widget.id);
    print('continue id ${Get.find<AuthController>().continueID}');

    videoPlayerController.addListener(() async {

      if(videoPlayerController.value.duration == videoPlayerController.value.position){
        if(_changeVideo){
          Get.find<AuthController>().updateContinue(
            filmID: widget.filmId,
            id: Get.find<AuthController>().continueID ?? widget.id,
            progressing: videoPlayerController.value.position.inSeconds.toString(),
            watchAt: DateTime.now().toString(),
          );
        }
      }
     if(_changeVideo){
       if( videoPlayerController.value.isPlaying == false){
         if (!apiCalledDuringPause) {
           apiCalledDuringPause = true;
           Get.find<AuthController>().checkContinue(
               film_id: widget.filmId,
               episode_id: Get.find<AuthController>().episodeID!,
               processing: videoPlayerController.value.position.inSeconds.toString()
           ).then((value) {
             if(value != 'ok'){
               Get.find<AuthController>().newContinue(
                   film_id: widget.filmId,
                   duration: videoPlayerController.value.duration.inSeconds.toString(),
                   film_type: "episode",
                   episodeNumber: Get.find<AuthController>().episodeNumber!,
                   episode_id: Get.find<AuthController>().episodeID!,
                   progressing: videoPlayerController.value.position.inSeconds.toString(),
                   watched_at: DateTime.now().toString());
             }
           });
         }
       } else {
         apiCalledDuringPause = false;
       }
     }
      if (videoPlayerController.value.isInitialized) {
        _progress = (videoPlayerController.value.position.inSeconds * 100) / videoPlayerController.value.duration.inSeconds;
        if (AppSettings.isAutoPlayVideo.value && videoPlayerController.value.position >= videoPlayerController.value.duration) {
          videoPlayerController.pause();
          Get.find<AuthController>().checkContinue(
              film_id: widget.filmId,
              episode_id: Get.find<AuthController>().episodeID!,
              processing: videoPlayerController.value.position.inSeconds.toString()
          ).then((value) {
            if(value != 'ok'){
              Get.find<AuthController>().newContinue(
                  film_id: widget.filmId,
                  duration: videoPlayerController.value.duration.inSeconds.toString(),
                  film_type: "episode",
                  episodeNumber: Get.find<AuthController>().episodeNumber!,
                  episode_id: Get.find<AuthController>().episodeID!,
                  progressing: videoPlayerController.value.position.inSeconds.toString(),
                  watched_at: DateTime.now().toString());
            }
          });

        }

        videoPosition.value = videoPlayerController.value.position.inMilliseconds;
      }
    });

    autoNextEpisode();

    // Trigger a rebuild of the widget with the new video
    setState(() {});
  }

  void autoNextEpisode()async
  {
    videoPlayerController.addListener(() {
      _progress = (videoPlayerController.value.position.inSeconds * 100) / videoPlayerController.value.duration.inSeconds;
      if(_progress >= 90){
        setState(() {
          _showNextEpisode = true;
          print('show next episode');
        });
        _controller = AnimationController(
          duration: Duration(seconds: 2),
          vsync: this,
        )..repeat(reverse: true);

        _colorAnimation = ColorTween(
          begin: Colors.red,
          end: Colors.redAccent,
        ).animate(_controller);

        _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
        _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
      }
      else {
        setState(() {
          _showNextEpisode = false;
        });
      }
    });



  }


  @override
  void initState() {

    print('dfsdfsdf');
    _checkHeadsetStatus();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,

    ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initializeVideoPlayer(widget.url);setState(() {});
    });


    // AutoNextVideo();
    super.initState();
  }



  @override
  void dispose() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
    chewieController?.dispose();
    _controller.dispose();
    subtitleController.detach();
    chewieController = null;

    videoPlayerController.dispose();
    Get.find<AuthController>().ownContinue();
    Get.find<FilmController>().filmDetail(id: int.parse(widget.filmId));
    Get.find<AuthController>().newContinue(
        film_id: widget.filmId,
        duration: videoPlayerController.value.duration.inSeconds.toString(),
        film_type: "episode",
        episodeNumber: Get.find<AuthController>().episodeNumber!,
        episode_id: Get.find<AuthController>().episodeID!,
        progressing: videoPlayerController.value.position.inSeconds.toString(),
        watched_at: DateTime.now().toString());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ));
    return PopScope(
      onPopInvoked: (didPop) async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        // 300.milliseconds.delay();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
          onTap: () {
            if(chewieController != null && videoPlayerController != null && videoPlayerController.value.isInitialized && _isLoading == false){
              isShowControl = !isShowControl!;

              setState(() {
                _customSubSize = false;
              });
            }


          },
          child: OrientationBuilder(
              builder: (context, orientation) => _isLoading && videoPlayerController == null && chewieController == null ?Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:  AssetImage('assets/image/bg.png'), fit: BoxFit.cover)
                ),
                child: Center(
                  child: buildLoading(),
                ),
              ) :Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: chewieController != null && videoPlayerController != null && videoPlayerController.value.isInitialized
                        ? GestureDetector(
                      child: Container(
                        height: orientation == Orientation.landscape ? Get.height : Get.height / 3,
                        width: Get.width,
                        color: Colors.black,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: orientation == Orientation.landscape ? Get.height : Get.height / 3,
                              width: Get.width,
                              child: FittedBox(
                                fit: _fitScreen ? BoxFit.cover : BoxFit.contain,
                                child: GetBuilder<FilmController>(
                                  builder: (context) {
                                    return SizedBox(
                                        width: videoPlayerController.value.size.width,
                                        height: videoPlayerController.value.size.height,
                                        child:isAirPlayConnected != true ? SubtitleWrapper(
                                            videoPlayerController: videoPlayerController,
                                            backgroundColor: Colors.black.withOpacity(0.5),
                                            subtitleController: subtitleController,
                                            subtitleStyle: SubtitleStyle(
                                              textColor: Colors.white,
                                              fontSize: context.subtitleSize,
                                              hasBorder: false,
                                              position: SubtitlePosition(
                                                bottom: context.subPosition,
                                                left: 50,
                                                right: 50,
                                              ),
                                            ),
                                            videoChild: Chewie(controller: chewieController!))
                                    : Container(
                                      width: Get.width,
                                      height: Get.height,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text('Airplay Connected', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),),
                                      ),

                                                                  ),
                                                                  );
                                  }
                                ),
                            ))
                          ],
                        ),
                      ),
                    )
                        : Container(height: orientation == Orientation.landscape ? Get.height : Get.height / 3.5, width: Get.width, color: Colors.black, child: Container(
                      width: Get.width,
                      height: Get.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:  AssetImage('assets/image/bg.png'), fit: BoxFit.cover)
                      ),
                      child: Stack(
                        children: [
                 ! _changeVideo ?        Positioned(
                            top:orientation == Orientation.landscape ? 35 : 55,
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                                color: Colors.white,
                              ).paddingOnly(left: 15),
                              onTap: () async {
                                await SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                                 Get.find<AuthController>().byFilm(film_id: widget.filmId);
                                 Get.find<FilmController>().filmDetail(id: int.parse(widget.filmId));

                                videoPlayerController.pause();

                                setState(() {});


                                Get.back();

                              },
                            ),
                          ) : SizedBox(),
                          buildLoading(),
                        ],
                      ),
                    )),
                  ),

                  isShowControl == true ?  Positioned(
                    top: orientation == Orientation.landscape ? 35 : 55,
                    child: SizedBox(
                      width: Get.width,
                      height: 60,
                      child: Row(
                        children: [
                          SizedBox(width: Get.width * 0.02),
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            ).paddingOnly(left: 15),
                            onTap: () async {
                              await SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                              ]);
                              await Get.find<AuthController>().byFilm(film_id: widget.filmId);
                              await Get.find<FilmController>().filmDetail(id: int.parse(widget.filmId));
                              videoPlayerController.pause();
                              setState(() {
                              });
                              Get.back();

                            },
                          ),
                          SizedBox(width: Get.width * 0.02),
                          SizedBox(
                            width: Get.width / 1.2,
                            child: Text(
                              '${Get.find<AuthController>().continueByFilmModel!.data!.title}    ( ${'Episode'.tr} ${Get.find<AuthController>().episodeNumber} )',
                              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),


                        ],
                      ),
                    ),
                  ) :SizedBox(),
                  isShowControl == true ?   Center(
                    child: SizedBox(
                      width: Get.width / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.replay_10,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () async => await backwardSkipVideo(),
                              ),
                              SizedBox(width: Get.width * 0.1),
                              IconButton(
                                icon: ImageIcon(
                                  AssetImage(
                                    chewieController != null && videoPlayerController != null && videoPlayerController.value.isInitialized ? videoPlayerController.value.isPlaying ? 'assets/image/pause.png' : 'assets/image/Previous.png' : 'assets/image/Previous.png',
                                  ),
                                  size: 35,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (videoPlayerController.value.isPlaying) {
                                    videoPlayerController.pause();
                                  } else {
                                    _customSubSize = false;
                                    isShowControl = false;
                                    videoPlayerController.play();
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: Get.width * 0.1),
                              IconButton(
                                icon: Icon(
                                  Icons.forward_10,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () async => await forwardSkipVideo(),
                              ),
                            ],
                          ),
                          SizedBox(height: 60),
                          // BannerAdAdmob()
                        ],
                      ),
                    ),
                  ) : SizedBox(),

                  isShowControl == true ? chewieController != null && videoPlayerController != null && videoPlayerController.value.isInitialized ? Positioned(
                    bottom: 00,
                    child: SizedBox(
                      width: Get.width,
                      // height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.8)],
                          ),
                        ),
                        child: SizedBox(

                          child: GetBuilder<FilmController>(
                            builder: (filmController) {
                              return Column(
                                children: [
                                  _customSubSize  ? SizedBox():  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Obx(
                                            () => Text(
                                          CustomFormatTime.convert(videoPosition.value),
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            trackHeight: 6,
                                            trackShape: const RoundedRectSliderTrackShape(),
                                            inactiveTrackColor: Colors.white60,
                                            thumbColor: Colors.white,
                                            activeTrackColor: Colors.red,
                                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
                                          ),
                                          child: Obx(
                                                () => Slider(
                                              value: videoPosition.toDouble(),
                                              onChanged: (double value) {
                                                final newPosition = Duration(milliseconds: value.toInt());
                                                videoPlayerController.seekTo(newPosition);
                                              },
                                              min: 0.0,
                                              max: videoPlayerController.value.duration.inMilliseconds.toDouble(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        CustomFormatTime.convert(videoPlayerController.value.duration.inMilliseconds ?? 0),
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                 _customSubSize ?
                                 Container(
                                   width: Get.width * 0.7,
                                   child: Column(
                                     children: [

                                       SliderTheme(
                                         data: SliderTheme.of(context).copyWith(
                                           trackHeight: 6,
                                           trackShape: const RoundedRectSliderTrackShape(),
                                           inactiveTrackColor: Colors.white60,
                                           thumbColor: Colors.white,
                                           activeTrackColor: Colors.blue,
                                           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                           overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
                                         ),
                                         child: Slider(
                                           value: filmController.subtitleSize,
                                           onChanged: (double value) {
                                             setState(() {
                                               //save to local

                                                filmController.setSubtitleSize(value);

                                             });
                                           },
                                           min: 30.0,
                                           max: 70.0,
                                         ),
                                       ),
                                       SliderTheme(
                                         data: SliderTheme.of(context).copyWith(
                                           trackHeight: 6,
                                           trackShape: const RoundedRectSliderTrackShape(),
                                           inactiveTrackColor: Colors.white60,
                                           thumbColor: Colors.white,
                                           activeTrackColor: Colors.green,
                                           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                           overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
                                         ),
                                         child: Slider(
                                           value: filmController.subPosition,
                                           onChanged: (double value) {
                                             setState(() {
                                              filmController.setSubPosition(value);

                                             });
                                           },
                                           min: 0.0,
                                           max: Get.height,
                                         ),
                                       ),
                                     ],
                                   ),
                                 )
                                     : Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(width: Get.width * 0.1),
                                     Get.find<AuthController>().continueByFilmModel!.data!.episodes!.length ==  1 || int.parse(Get.find<AuthController>().episodeNumber!) == 1 ?  SizedBox():
                                     InkWell(
                                       onTap: ()async{

                                         setState(() {
                                           _changeVideo = true;
                                         });

                                         int currentEpisodeNumber = int.parse(Get.find<AuthController>().episodeNumber ?? '1');
                                         if(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber].continueId == null){

                                         }
                                         else {
                                           await Get.find<AuthController>().updateContinue(
                                             filmID: widget.filmId,
                                             id: Get.find<AuthController>().continueID!,
                                             progressing: videoPlayerController.value.position.inSeconds.toString(),
                                             watchAt: DateTime.now().toString(),
                                             isPrevious: true,
                                           ).then((value) async {
                                             if(value == 'ok'){
                                               print('value pre   $value');
                                               await Get.find<AuthController>().setEpisodeNumber((currentEpisodeNumber - 1).toString());
                                               await Get.find<AuthController>().setFilmURL(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 2].file ?? '');
                                               await Get.find<AuthController>().setEpisodeID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber -2].id.toString());
                                               await Get.find<AuthController>().setStartTime(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 2].progressing.toString());
                                               await  Get.find<AuthController>().setContinueID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 2].continueId.toString());
                                               changeVideo();
                                             }
                                             else {
                                               Get.snackbar('Error', 'Error');
                                               setState(() {});
                                             }
                                           });
                                         }

                                       },
                                       child: Row(
                                         children: [
                                           FaIcon(FontAwesomeIcons.arrowAltCircleLeft,color: Colors.white,),
                                           SizedBox(width: 15),
                                           Text(
                                             'previous'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),)
                                         ],
                                       ),
                                     ),
                                     // SizedBox(width: Get.width * 0.05),
                                     InkWell(
                                       onTap:()async{

                                         videoPlayerController.pause();
                                         setState(() {});
                                         Get.bottomSheet(
                                             Column(
                                               mainAxisSize: MainAxisSize.max,
                                               children: [
                                                 buildListButtomSheet(
                                                   image: widget.images,
                                                 ),
                                               ],
                                             ),

                                             backgroundColor: Colors.black,
                                             isScrollControlled: true,
                                             shape: const RoundedRectangleBorder(
                                               borderRadius: BorderRadius.only(
                                                 topLeft: Radius.circular(20),
                                                 topRight: Radius.circular(20),
                                               ),
                                             ));
                                       },
                                       child: Row(
                                         children: [
                                           ImageIcon(
                                             AssetImage(
                                               'assets/icon/group2.png',
                                             ),
                                             size: 30,
                                             color: Colors.white,
                                           ),
                                           SizedBox(width: 15),
                                           Text(
                                             'episodes'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),)
                                         ],
                                       ),
                                     ),
                                     GestureDetector(
                                       onTap: () async {
                                         setState(() {
                                           _fitScreen = !_fitScreen;
                                         });
                                         if(_fitScreen){
                                           setState(() {
                                             SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                                             SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
                                           });
                                         }
                                         else {

                                         }
                                       },
                                       child: Row(
                                         children: [
                                           FaIcon(FontAwesomeIcons.tabletScreenButton,color: Colors.white,),
                                           SizedBox(width: 15),
                                           Text(
                                             '${_fitScreen ? 'un_fit' : 'fit_screen'}'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),)
                                         ],
                                       ),
                                     ),
                                     InkWell(
                                       onTap: () async {
                                         videoPlayerController.pause();
                                         setState(() {

                                         });
                                         if(Get.find<FilmController>().subtitleModel!.data!.isEmpty){
                                           videoPlayerController.play();
                                           showCustomSnackBar('this_episode_not_has_external_sub_yet'.tr, isError: true);
                                         }
                                         else {
                                           Get.bottomSheet(
                                               Column(
                                                 mainAxisSize: MainAxisSize.max,
                                                 children: [
                                                   buildButtomSheetForSubtitle(),
                                                 ],
                                               ),

                                               backgroundColor: Colors.black,
                                               isScrollControlled: true,
                                               shape: const RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(20),
                                                   topRight: Radius.circular(20),
                                                 ),
                                               ));
                                         }


                                       },
                                       child: Row(
                                         children: [
                                           ImageIcon(
                                             AssetImage(
                                               'assets/icon/subtitle.png',
                                             ),
                                             size: 30,
                                             color: Colors.white,
                                           ),
                                           SizedBox(width: 15),
                                           Text('subtitle'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     InkWell(
                                      onTap: (){
                                        setState(() {
                                          _customSubSize = !_customSubSize;
                                        });
                                      },
                                       child: Row(
                                         children: [
                                            FaIcon(FontAwesomeIcons.textHeight, color: Colors.white,),
                                           SizedBox(width: 15),
                                           Text('custom_sub'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     // SizedBox(width: Get.width * 0.05),
                                     Get.find<AuthController>().continueByFilmModel!.data!.episodes!.length ==  int.parse(Get.find<AuthController>().episodeNumber!) ?  SizedBox():
                                     InkWell(
                                       onTap: () async {
                                         videoPlayerController.pause();
                                         setState(() {
                                           _changeVideo = true;
                                         });


                                         int currentEpisodeNumber = int.parse(Get.find<AuthController>().episodeNumber ?? '1');
                                         await Get.find<AuthController>().newContinue(
                                           film_id: widget.filmId,
                                           duration: videoPlayerController.value.duration.inSeconds.toString(),
                                           film_type: "episode",
                                           episodeNumber: Get.find<AuthController>().episodeNumber!,
                                           episode_id: Get.find<AuthController>().episodeID!,
                                           progressing: videoPlayerController.value.position.inSeconds.toString(),
                                           watched_at: DateTime.now().toString(),
                                           isNext: true,
                                         ).then((value) async {
                                           if(value == 'ok'){
                                             await Get.find<AuthController>().setEpisodeNumber((currentEpisodeNumber + 1).toString());
                                             currentEpisodeNumber = int.parse(Get.find<AuthController>().episodeNumber ?? '1');
                                             // print('continue uid ${Get.find<AuthController>().continueID} $currentEpisodeNumber ggg ${Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber].file}');
                                             await Get.find<AuthController>().setFilmURL(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 1].file ?? '');

                                             await Get.find<AuthController>().setEpisodeID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 1].id.toString());
                                             await Get.find<AuthController>().setStartTime(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber- 1].progressing.toString());
                                             await  Get.find<AuthController>().setContinueID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber- 1].continueId.toString());
                                             changeVideo();
                                           }
                                         });

                                       },
                                       child: Row(
                                         children: [
                                           FaIcon(FontAwesomeIcons.arrowAltCircleRight, color: Colors.white,),
                                           SizedBox(width: 15),
                                           Text(
                                             'next'.tr,
                                             style: GoogleFonts.roboto(
                                               color: Colors.white,
                                               fontSize: 16,
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     const SizedBox(width: 60),
                                   ],
                                 ),
                                  SizedBox(height: 30),
                                ],
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ) : SizedBox() : SizedBox(),
     Get.find<AuthController>().episodeNumber != Get.find<AuthController>().continueByFilmModel?.data?.episodes?.length.toString() &&                   _showNextEpisode == true ? chewieController != null && videoPlayerController != null && videoPlayerController.value.isInitialized  ?

                  Positioned(
                    top: Get.height / 2.5,
                    right: 40,
                    child: GestureDetector(
                      onTap: () async {
                        videoPlayerController.pause();
                        setState(() {
                          _changeVideo = true;
                        });


                        int currentEpisodeNumber = int.parse(Get.find<AuthController>().episodeNumber ?? '1');
                        await Get.find<AuthController>().newContinue(
                          film_id: widget.filmId,
                          duration: videoPlayerController.value.duration.inSeconds.toString(),
                          film_type: "episode",
                          episodeNumber: Get.find<AuthController>().episodeNumber!,
                          episode_id: Get.find<AuthController>().episodeID!,
                          progressing: videoPlayerController.value.duration.inSeconds.toString(),
                          watched_at: DateTime.now().toString(),
                          isNext: true,
                        ).then((value) async {
                          if(value == 'ok'){
                            await Get.find<AuthController>().setEpisodeNumber((currentEpisodeNumber + 1).toString());
                            currentEpisodeNumber = int.parse(Get.find<AuthController>().episodeNumber ?? '1');
                            // print('continue uid ${Get.find<AuthController>().continueID} $currentEpisodeNumber ggg ${Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber].file}');
                            await Get.find<AuthController>().setFilmURL(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 1].file ?? '');

                            await Get.find<AuthController>().setEpisodeID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber - 1].id.toString());
                            await Get.find<AuthController>().setStartTime(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber- 1].progressing.toString());
                            await  Get.find<AuthController>().setContinueID(Get.find<AuthController>().continueByFilmModel!.data!.episodes![currentEpisodeNumber- 1].continueId.toString());
                            changeVideo();
                          }
                        });

                      },
                      onTapDown: (details) {
                        setState(() {
                          _isHovered = true;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          _isHovered = false;

                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _changeVideo = false;
                          _isHovered = false;
                        });
                      },
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _colorAnimation.value,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _colorAnimation.value!.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'next_episode'.tr,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            );
                          }),

                    ),
                  ) : SizedBox() : SizedBox(),
                ],
              )),
        ),
      ),
    );
  }
  Widget buildListButtomSheet ({required String image}){
    return StatefulBuilder(
      builder: (context, setState) {
        return GetBuilder<AuthController>(
          builder: (controller) {
            var film = controller.continueByFilmModel?.data;
            return Container(
              width: MediaQuery.of(context).size.width, // Full width
              height: MediaQuery.of(context).size.height, // Full height
              child: film?.episodes?.length == 0
                  ? Center(
                child: Text('No Data Found'),
              )
                  : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                        onPressed: () async {
                          Get.back();
                          videoPlayerController.play();
                          setState(() {});
                        },
                      ),

                      customRegularTextStyle(text: film?.title ?? '', fontSize: 20, ),
                      SizedBox(width: 30,),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: film?.episodes?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {

                                  _changeVideo = true;
                                });
                                await Get.find<AuthController>().updateContinue(
                                  filmID: widget.filmId,
                                  id: Get.find<AuthController>().continueID ?? widget.id,
                                  progressing: videoPlayerController.value.position.inSeconds.toString(),
                                  watchAt: DateTime.now().toString(),
                                );
                            await  controller.setFilmURL(film.episodes?[index].file ?? '');
                             await controller.setFilmID(film.id.toString());
                             await controller.setEpisodeID(film.episodes![index].id.toString());
                             await controller.setStartTime(film.episodes![index].progressing.toString());
                                await controller.setEpisodeNumber(film.episodes![index].episode.toString());
                                await  controller.setContinueID(film.episodes![index].continueId.toString());
                                print('continue id ${film.episodes![index].continueId}');
                             changeVideo();
                             setState(() {
                               _isLoading = true;
                             });
                              Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 100,
                                  height: 130,
                                  child: Stack(
                                    children: [

                                  Container(
                                        width: 100,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                    child: CachedNetworkImage(
                                      imageUrl: image,
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.grey[300]!,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                      ),
                                      film!.episodes![index].status == 'watched' ? Container(
                                        width: 100,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Lottie.asset('assets/animation/done.json', width: 100, height: 130,repeat: false),
                                      ) : SizedBox(),
                                      film.episodes![index].episode == Get.find<AuthController>().episodeNumber ? Container(
                                        width: 100,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.pause, color: Colors.white, size: 50,),
                                      ) : SizedBox(),
                                      film.episodes![index].status == 'progressing' ?
                                      Positioned(
                                        bottom: 50,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Container(
                                              width: film?.episodes?[index].progressing == null ? 0:  (double.parse(film!.episodes![index].progressing.toString()) * 100) / (double.parse(film.episodes![index].duration.toString())),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ) : Container(),
                                      Positioned(
                                        bottom: 8,
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: customRegularTextStyle(text: '${'Episode'.tr} ${film?.episodes?[index].episode ?? ''}', fontSize: 12, color: Colors.white),
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
                      )
                  ),
                ],
              ),
            );
          },
        );
      },

    );
  }

  Widget buildButtomSheetForSubtitle (){
    return StatefulBuilder(
      builder: (context, setState) {
        return GetBuilder<FilmController>(
          builder: (controller){
            return Container(
              width: MediaQuery.of(context).size.width, // Full width
              height: MediaQuery.of(context).size.height, // Full height
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white,),
                        onPressed: (){

                          Get.back();
                          setState(() {
                            videoPlayerController.play();
                          });

                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.subtitleModel?.data?.length,
                        itemBuilder:(context, index){
                          return Container(
                            width: Get.width,
                            height: 100,

                            child: Column(
                              children: [

                                Expanded(
                              child: ListTile(
                              title: Text("${controller.subtitleModel?.data?[index].language?? ''} ( ${controller.subtitleModel?.data?[index].status} )" '', style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),),
                              onTap: () async {
                                controller.subtitleModel?.data?[index].url == null ? showCustomSnackBar('this_subtitle_is_for_premium_user_only'.tr,isError: true) :
                              subtitleController.updateSubtitleUrl(url: '${controller.subtitleModel?.data?[index].url}');
                              Get.find<AuthController>().setSubtitleIndex(index);
                              setState(() {
                              videoPlayerController.play();
                              });
                              Get.back();
                              },
                              leading: Icon(Icons.language, color: Colors.white,),
                              trailing: Icon(Get.find<AuthController>().subtitleIndex == index ? Icons.check : null, color: Colors.white,),
                              ),
                            ),
                             //show 1 only last subtitle
                             //  index == controller.subtitleModel!.data!.length - 1 ?
                             //      Padding(
                             //        padding: const EdgeInsets.only(left: 2.0,top: 10),
                             //        child: ListTile(
                             //          title: Text('close_subtitle'.tr, style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),),
                             //          onTap: () async {
                             //            subtitleController.updateSubtitleUrl(url: '');
                             //            Get.find<AuthController>().setSubtitleIndex(index + 1);
                             //            setState(() {
                             //              videoPlayerController.play();
                             //            });
                             //            Get.back();
                             //          },
                             //          leading: Icon(Icons.language, color: Colors.white,),
                             //          trailing: Icon(Get.find<AuthController>().subtitleIndex == index + 1 ? Icons.check : null, color: Colors.white,),
                             //        ),
                             //      ):SizedBox(),

                              ],
                            ),
                          );
                        }
                    ),
                  ),


                ],
              ),
            );
          },
        );
      },
    );
  }
}
class BorderPainter extends CustomPainter {
  final Animation<double> animation;

  BorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 6.28,
        colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
        stops: [
          animation.value,
          animation.value + 0.25,
          animation.value + 0.5,
          animation.value + 0.75
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = Radius.circular(10);

    canvas.drawRRect(RRect.fromRectAndCorners(
      rect,
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
    ), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

