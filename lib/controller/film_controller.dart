import 'dart:async';
import 'dart:io';


import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/data/model/SearchMovieModel.dart';
import 'package:miss_planet/data/model/comingSoonFilmModel.dart';
import 'package:miss_planet/data/model/filmListModel.dart' hide Films;
import 'package:miss_planet/data/model/genreModel.dart';
import 'package:miss_planet/data/model/homeListModel.dart';
import 'package:miss_planet/data/model/listRateModel.dart';
import 'package:miss_planet/data/model/movieDetailModel.dart';
import 'package:miss_planet/data/model/subtitleModel.dart';
import 'package:miss_planet/data/model/watchMovieListModel.dart';
import 'package:miss_planet/data/repository/film_repository.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';

import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FilmController extends GetxController implements GetxService {
  final FilmRepository filmRepository;
  final SharedPreferences sharedPreferences;

  FilmController(
      {required this.filmRepository, required this.sharedPreferences}) {}

  // set

  FilmListModel _filmListModel = FilmListModel();
  MovieDetailModel _movieDetailModel = MovieDetailModel();
  ListRateModel _listRateModel = ListRateModel();
  WatchMovieListModel _watchMovieListModel = WatchMovieListModel();
  SearchMovieModel _searchWatchMovie = SearchMovieModel();
  GenreModel _genreModel = GenreModel();
  HomeListModel _homeListModel = HomeListModel();
  SubtitleModel? _subtitleModel;
  bool _isloding = false;
  bool _loadMore = false;
  int _currentPage = 1;
  int _pageWatchMovie = 1;
  List<dynamic> _requestList = [];
  Map<String,List<ComingSoonFilmModel?>>? _comingSoonModel;
  static RxList<Map<String, dynamic>> mainDownloadHistory = <Map<String, dynamic>>[].obs;
  double _rating = 0;
  String _allRating = '0';
  int _id = 0;
  String _videoUrl = '';
  String? playUrl = '';
  double? progress;
  String currentEpId = '';
  bool isShowVideoControls = true;
  bool _isDownloading = false;
  String? _imageDownloadPath;
  String? _downloadedPath;
  String _countDownload = '0';
  double _subPosition = Get.height * 0.6;
  double _subtitleSize = 30.0; // Initial value
  // get

  FilmListModel get filmListModel => _filmListModel;
  MovieDetailModel get movieDetailModel => _movieDetailModel;
  WatchMovieListModel get watchMovieListModel => _watchMovieListModel;
  SearchMovieModel get searchWatchMovie => _searchWatchMovie;
  ListRateModel get listRateModel => _listRateModel;
  GenreModel get genreModel => _genreModel;
  HomeListModel get homeListModel => _homeListModel;
  SubtitleModel? get subtitleModel => _subtitleModel;
  bool get isloding => _isloding;
  bool get loadMore => _loadMore;
  int get currentPage => _currentPage;
  int get pageWatchMovie => _pageWatchMovie;
  List<dynamic> get requestList => _requestList;
  double get rating => _rating;
  String get allRating => _allRating;
  int get id => _id;
  String get videoUrl => _videoUrl;
  bool get isDownloading => _isDownloading;
  String get imageDownloadPath => _imageDownloadPath!;
  String? get downloadedPath => _downloadedPath;
  String? get countDownload => _countDownload;
  Map<String,List<ComingSoonFilmModel?>>? get comingSoonModel => _comingSoonModel;

  double get subPosition => _subPosition;
  double get subtitleSize => _subtitleSize;

  setSubtitleSize(double size) {
    _subtitleSize = size;
    update();
  }

  setSubPosition(double position) {
    _subPosition = position;
    update();
  }

  setRating(double rating) {
    _rating = rating;
    update();
  }

  setCountDownload(String count) {
    _countDownload = count;
    update();
  }

  setCurrentEpId(String? id) {
    currentEpId = id!;
    update();
  }

  setLoadMore(bool loadMore) {
    _loadMore = loadMore;
    update();
  }

  setUrl(String url) {
    _videoUrl = url;
    update();
  }

  setId(int id) {
    _id = id;
    update();
  }

  setPage() {
    _currentPage = _currentPage + 1;
    update();
  }

  setPageWatchMovie() {
    _pageWatchMovie = _pageWatchMovie + 1;
    update();
  }

  setIsLoding(bool isLoding) {
    _isloding = isLoding;
    update();
  }

  clearSearchMovie() {
    _searchWatchMovie = SearchMovieModel();
    update();
  }

  void showVideoControls() {
    isShowVideoControls = !isShowVideoControls;
    update(["onShowControls"]);
  }

  // Future<double?> getProgress(
  //     {required String movieId, required String episodeId}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? listEp = await prefs.getStringList(movieId);
  //
  //   if (listEp != null) {
  //     listEp.forEach((element) async {
  //       if (element == episodeId) {
  //         progress = await prefs.getDouble(episodeId);
  //         update();
  //       }
  //     });
  //   }
  //   return progress;
  // }

  StreamSubscription<List<int>>? _downloadSubscription;

//   Future DownloadVideo({required String videoUrl, required String videoId, required String epNumber, required String title, required String duration, required String image, required String imageExtention}) async {
//     try {
//       if (videoUrl != null) {
//         _isDownloading = true;
//         final client = http.Client();
//         final request = http.Request('GET', Uri.parse(videoUrl));
//         final http.StreamedResponse response = await client.send(request);
//
//         final documentDirectory = await getApplicationDocumentsDirectory();
//         final filePath = documentDirectory.path;
//         final downloadPath = '$filePath/MyDownload';
//         Directory(downloadPath).createSync(recursive: true);
//         final downloaded = '$downloadPath/$videoId.mp4';
//         final File file = File(downloaded);
//
//         IOSink sink = file.openWrite();
//
//         int bytesDownloaded = 0;
//         _downloadSubscription = response.stream.listen(
//               (List<int> chunk) {
//             sink.add(chunk);
//             bytesDownloaded += chunk.length;
//             double progress = bytesDownloaded / response.contentLength!;
//             print('Download Progress: $progress');
//
//             _countDownload= '${(progress * 100).toStringAsFixed(0)}';
//             update();
//           },
//           onDone: () async {
//             await sink.close();
//             print('Download Completed');
//             CustomToast.show('videoDownloaded'.tr);
//             // final downloadHistory = DownloadHistory.mainDownloadHistory;
// //download image and save it
//             final imageResponse = await http.get(Uri.parse(image));
//             final imageBytes = imageResponse.bodyBytes;
//             final imageFile = File('$downloadPath/$videoId.jpg');
//             await imageFile.writeAsBytes(imageBytes);
//             downloadHistory.addAll([
//               {
//                 "videoId": videoId,
//                 'episodeNumber' : epNumber,
//                 "filmID" : videoId,
//                 "videoTitle": title,
//                 "videoType": 'mp4',
//                 "videoTime": duration,
//                 "videoUrl": downloadPath,
//                 "image" : '$downloadPath/$videoId.jpg',
//               },
//             ]);
//             // DownloadHistory.onSet();
//             _isDownloading = false;
//             _countDownload = '0';
//             update();
//
//           },
//           onError: (e) {
//             print('Download Error: $e');
//             CustomToast.show('videoDownloadingFailed'.tr);
//           },
//           cancelOnError: true,
//         );
//       }
//     } catch (e) {
//       print('Download Error: $e');
//       CustomToast.show('videoDownloadingFailed'.tr);
//     }
//   }

  Future cancelDownload() async {
    await _downloadSubscription?.cancel();
    _isDownloading = false;
    _countDownload = '0';
    update();
  }

  Future<void> checkFileExists(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      _imageDownloadPath = filePath;
    print('File exists');
    // Continue with your operation
    } else {
    print('File not found');
    // Handle the situation when the file does not exist
    }
  }

// Use the function

  Future GetAllVideoDownload () async {
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = documentDirectory.path;
      final downloadPath = '$filePath/MyDownload';
      final downloaded = '$downloadPath';
      final File file = File(downloaded);
      print('Downloaded: $downloaded');
      _downloadedPath = downloaded;


      if (file.existsSync()) {
        print('------------------------');
        print(downloaded);
        print('------------------------');
        return downloaded;
      }

    } catch (e) {
      print('Download Error: $e');
    }
  }

  Future GetDownloadedVideo ({required String videoId}) async {
    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = documentDirectory.path;
      final downloadPath = '$filePath/MyDownload';
      final downloaded = '$downloadPath/$videoId.mp4';
      final File file = File(downloaded);
      if (file.existsSync()) {
        return downloaded;
      }
    } catch (e) {
      print('Download Error: $e');
    }
  }


  Future getFilm({int? page}) async {
    try {
      Response apiResponse = await filmRepository.getFilm(page: page ?? 1);
      if (apiResponse.statusCode == 200) {
        _filmListModel = FilmListModel.fromJson(apiResponse.body);
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future increaseView({required int id}) async {
    try {
      Response apiResponse = await filmRepository.increaseView(id: id);
      if (apiResponse.statusCode == 200) {
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getHomeApi() async {
    try {
      Response apiResponse = await filmRepository.getHomeApi();
      if (apiResponse.statusCode == 200) {
        _homeListModel = HomeListModel.fromJson(apiResponse.body);

        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future filmDetail({required int id}) async {
    try {
      Response apiResponse = await filmRepository.filmDetail(id: id);
      if (apiResponse.body['code'] == 200){
        _movieDetailModel = MovieDetailModel.fromJson(apiResponse.body);
        // Get.find<ArticalController>().checkNotify(id: id, type_id: 2);
        //if user stay on this page for 5 seconds, increase view
        Timer(Duration(seconds: 5), () {
          increaseView(id: id);
        });
        update();
        return 'OK';
      } else {
        showCustomSnackBar('something_when_wrong',  isError: true);
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future watchMovieList() async{
    try{
      Response apiResponse = await filmRepository.watchMovieList(page: _pageWatchMovie);
      if(apiResponse.body['code'] == 200){
        if(_pageWatchMovie == 1){
          _watchMovieListModel = WatchMovieListModel.fromJson(apiResponse.body);
          update();
        }
        else{
          _loadMore = true;
          apiResponse.body['data']['films'].forEach((e) {
            _watchMovieListModel.data!.films!.add(FilmInWatchMovie.fromJson(e));
            _loadMore = false;
            update();
          });
          update();
        }
        return apiResponse;
      }
      else {
        showCustomSnackBar('something_when_wrong', isError: true);
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future searchMovie({required String search}) async {
    try {
      Response apiResponse = await filmRepository.searchMovie(search: search);
      if (apiResponse.statusCode == 200) {
        _searchWatchMovie = SearchMovieModel.fromJson(apiResponse.body);
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future editFilm({required String title, required String description, required String release_date,   XFile? poster,  XFile? cover, required String trailer, required String running_time, required int id})
  async {
    try {
      Response apiResponse = await filmRepository.editFilm(title: title,
          id: id,
          description: description,
          release_date: release_date,
          poster: poster,
          cover: cover,
          trailer: trailer,
          running_time: running_time);
      if (apiResponse.statusCode == 200) {
        update();

        return 'ok';
      }
      else {
        return 'error';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future rateFilm({required int id, required String rating}) async {
    try {
      _isloding = true;
      Response apiResponse =
          await filmRepository.rateFilm(id: id, rating: rating);
      if (apiResponse.statusCode == 200 &&
          apiResponse.body['status'] == 'success') {
        update();
        showCustomDialog(apiResponse.body['message'], Get.context!,
            isError: false);
        Future.delayed(Duration(seconds: 2), () {
          filmDetail(id: id);
          Get.back();
        });

        _isloding = false;
        return 'OK';
      }
      else if (apiResponse.statusCode == 200 &&
          apiResponse.body['status'] == 'error') {
        showCustomSnackBar(apiResponse.body['message'],
            isError: true);
        Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
        return apiResponse;
      }
      else if (apiResponse.statusCode == 401){
        showCustomDialog('${AppConstants().notLogin}', Get.context!,isError: true,onPressed: (){
          nextScreenReplace(Get.context!, LoginScreen());
        },hasOnpressed: true);
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future requestFilm(
      {required String title,
      required String link,
      String? description,
      required XFile image,
      String? noted}) async {
    try {
      _isloding = true;
      Response apiResponse = await filmRepository.requestFilm(
          title: title,
          link: link,
          description: description ?? 'No',
          image: image,
          noted: noted ?? 'No');
      if (apiResponse.statusCode == 200 &&
          apiResponse.body['status'] == 'success') {
        _isloding = false;
        update();
        showCustomDialog(apiResponse.body['message'], Get.context!,
            isError: false);
        Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
        return 'OK';
      } else if (apiResponse.statusCode == 200 &&
          apiResponse.body['status'] == 'error') {
        showCustomSnackBar(apiResponse.body['message'],
            isError: true);
        Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getFilmRequest() async {
    try {
      Response apiResponse = await filmRepository.getFilmRequest();
      if (apiResponse.statusCode == 200) {
        _requestList = apiResponse.body['message'];
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future shotByRate({ bool? watch}) async {
    try {
      _isloding = true;
      Response apiResponse = await filmRepository.shotByRate(page: '${_currentPage}', watch: watch ?? false);
      if (apiResponse.body['code'] == 200) {

        if (_currentPage == 1) {
          _listRateModel = ListRateModel.fromJson(apiResponse.body);
          update();
        }
        else {
          _loadMore = true;
          //add more
          apiResponse.body['data']['films'].forEach((e) {
            _listRateModel.data!.films!.add(Films.fromJson(e));
            _loadMore = false;
            update();
          });
          update();
        }
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeFilmType({required String id, required String typeID}) async {
    try {
      Response apiResponse = await filmRepository.changeFilmType(id: id, typeID: typeID);
      if (apiResponse.statusCode == 200) {
        getFilm();
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }
  Future comingSoon() async {
    try {
      Response apiResponse = await filmRepository.comingSoon();
      if (apiResponse.statusCode == 200) {
        _comingSoonModel = {};
        update();
        var data = apiResponse.body['data'];
        data.forEach((key, value) {
          List<ComingSoonFilmModel> _comingSoonModel2 = [];
          value.forEach((e) {
            _comingSoonModel2.add(ComingSoonFilmModel.fromJson(e));
            update();
          });
          _comingSoonModel!.addAll({key: _comingSoonModel2});
          // _comingSoonModel!.add({key: value.followedBy((e) => ComingSoonFilmModel.fromJson(e)).toList()});
          update();
          // _comingS
          // oonModel!.addAll({"$key": value.followedBy((e) => ComingSoonFilmModel.fromJson(e)).toList()});
          // _comingSoonModel = data;
        });
        // _comingSoonModel = ComingSoonFilmModel.fromJson(data);
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future addCategory({required String categoryId, required String filmID}) async {
    try {
      Response apiResponse = await filmRepository.addCategory(
          categoryId: categoryId, filmID: filmID);
      if (apiResponse.statusCode == 200) {
        filmDetail(id: int.parse(filmID));
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCategory({required String id}) async {
    try {
      Response apiResponse = await filmRepository.deleteCategory(id: id);
      if (apiResponse.statusCode == 200) {
        filmDetail(id: int.parse(id));
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getGenre() async {
    try {
      Response apiResponse = await filmRepository.getGenre();
      if (apiResponse.statusCode == 200) {
        _genreModel = GenreModel.fromJson(apiResponse.body);
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future addGenreToFilm({required String genreID, required String filmID}) async {
    try {
      Response apiResponse = await filmRepository.addGenreToFilm(
          genreID: genreID, filmID: filmID);
      if (apiResponse.statusCode == 200) {
        filmDetail(id: int.parse(filmID));
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Subtitle

  Future getSubtitle({required int id}) async {
    try {Response apiResponse = await filmRepository.getSubtitle(id: id);

      if (apiResponse.statusCode == 200) {
        _subtitleModel = SubtitleModel.fromJson(apiResponse.body);
        print('Subtitledfadsfadsfads: $id');
        update();
        return 'ok';
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }


}
