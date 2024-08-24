import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/data/model/articalModel.dart';
import 'package:miss_planet/data/model/movieDetailModel.dart';
import 'package:miss_planet/data/model/searchModel.dart';
import 'package:miss_planet/data/model/videoDetailModel.dart';
import 'package:miss_planet/data/repository/artical_repository.dart';
import 'package:miss_planet/screen/articals/artical_detail_screen.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:get/get.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ArticalController extends GetxController implements GetxService {
  final ArticalRepository articalRepository;
  final SharedPreferences sharedPreferences;

  ArticalController({required this.articalRepository, required this.sharedPreferences}) {}

  // set
  ArticlesListModel _articalListModel = ArticlesListModel();
  SearchModel _searchModel = SearchModel();

  Map _articalDetailModel = Map();
  List _articalDetailList = [];
  bool _isLike = false;
  bool _isNotify = false;
  bool _isFavorite = false;
  dynamic _FavoriteID;
  int _confessID = 0;
  bool _isLoding = false;
  int? _totalCountAllArticles;
  int _page = 1;
  bool _isLoadMore = false;


  // get
  ArticlesListModel get articalListModel => _articalListModel;
  SearchModel get searchModel => _searchModel;
  Map get articalDetailModel => _articalDetailModel;
  List get articalDetailList => _articalDetailList;
  bool get isLike => _isLike;
  bool get isNotify => _isNotify;
  bool get isFavorite => _isFavorite;
  dynamic get favoriteID => _FavoriteID;
  int get confessId => _confessID;
  bool get isLoding => _isLoding;
  int? get totalCountAllArtist => _totalCountAllArticles;
  int get page => _page;
  bool get isLoadMore => _isLoadMore;

  // set
  setIsNotify(bool isNotify){
    _isNotify = isNotify;
    update();
  }

  setIsFavorite(bool isFavorite){
    _isFavorite = isFavorite;
    update();
  }

  setConfesID(int id){
    _confessID = id;
    update();
  }

  setLoding(bool loding){
    _isLoding = loding;
    update();
  }

  setLoadMore(bool loadMore){
    _isLoadMore = loadMore;
    update();
  }

  setPage() {
    _page = _page + 1;
    update();
  }


  Future getArtical({int? page}) async {
    try {
      Response apiResponse = await articalRepository.getArtical(page: _page);
      if (apiResponse.statusCode == 200) {
       if(_page == 1) {
         _articalDetailList.length = 0;
         update();
         _totalCountAllArticles = apiResponse.body['data']['total'];
         _articalListModel = ArticlesListModel.fromJson(apiResponse.body);
         update();
       }
         else {
            _articalListModel.data!.articles!.addAll(apiResponse.body['data']['articles']);
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

  Future getArticalDetail({required int id}) async {
    try {
      Response apiResponse = await articalRepository.getArticalDetail(id: id);
      if (apiResponse.statusCode == 200) {
        _articalDetailModel.addAll(apiResponse.body['data']);
        checkNotify(id: id,type_id: 1);

        update();
        return 'ok';
      } else {
        showCustomDialog('Something when wrong', Get.context!);
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future makeNotify({required int postType, required int postID}) async {
    try {
      Response apiResponse = await articalRepository.makeNotify(postType: postType, postID: postID);
      if (apiResponse.statusCode == 200) {
        checkNotify(id: postID,type_id: postType);
        update();
        return apiResponse;
      } else if(apiResponse.statusCode == 401) {
        showCustomDialog('${AppConstants().notLogin}', Get.context!,isError: true,onPressed: (){
          nextScreenReplace(Get.context!, LoginScreen());
        },hasOnpressed: true);
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteNotify({required int postID, required int postType}) async {
    try {
      Response apiResponse = await articalRepository.deleteNotify(postID: postID, postType: postType);
      if (apiResponse.statusCode == 200) {
        _isNotify = false;
        checkNotify(id: postID, type_id: postType);
        update();
        return apiResponse;
      } else {

        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future checkNotify({required int id, required int type_id}) async {
    try {
      Response apiResponse = await articalRepository.checkNotify(id: id,type_id: type_id);
      if (apiResponse.statusCode == 200) {
        _isNotify = apiResponse.body['BookMark'];
        _isLike = apiResponse.body['Like'];
        _isFavorite = apiResponse.body['Favorite'];
        _FavoriteID = apiResponse.body['FavoriteId'] ?? null;
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future likeArticle({required int id}) async {
    try {
      Response apiResponse = await articalRepository.likeArticle(id: id);
      if (apiResponse.statusCode == 200) {
        checkNotify(id: id,type_id: 1);
        _articalDetailModel['like'] = _articalDetailModel['like'] + 1;
        showCustomDialog('thank_you_for_your_like', Get.context!,isError: false);
        update();
        return apiResponse;
      } else if(apiResponse.statusCode == 401) {
        showCustomDialog('${AppConstants().notLogin}', Get.context!,isError: true,onPressed: (){
          nextScreenReplace(Get.context!, LoginScreen());
        },hasOnpressed: true);
        return apiResponse;
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future shareArticle({required int id}) async {
    try {
      Response apiResponse = await articalRepository.shareArticle(id: id);
      if (apiResponse.statusCode == 200) {
        Share.share('${AppConstants.shareArticle}$id');
        // Future.delayed(Duration(seconds: 3), () {
        //   Get.back();
        // });
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  //Todo: comment
  // Future createComment({required int id, required String comment,required int type, required int confess}) async {
  //   try {
  //     Response apiResponse = await articalRepository.createComment(id: id, comment: comment,type: type, confess: confess);
  //     if (apiResponse.statusCode == 200) {
  //
  //       if(type == 1) {
  //         _articalDetailModel['comment'].add({
  //           "id": apiResponse.body['data']['id'],
  //           "content": apiResponse.body['data']['comment'],
  //           "user" : confess == 1 ? 'Anonymous' : Get.find<AuthController>().userModel!.data!.name,
  //           "created_at": apiResponse.body['data']['created_at'],
  //           "avatar" : confess == 1 ? 'https://cinemagickh.oss-ap-southeast-7.aliyuncs.com/398790-PCT3BY-905.jpg' : Get.find<AuthController>().userModel!.data!.avatar
  //         });
  //         _isLoding = false;
  //         update();
  //       }
  //       if(type == 2)
  //       {
  //         await Get.find<FilmController>().filmDetail(id: id);
  //         var filmDetailModel = Get.find<FilmController>().movieDetailModel;
  //       filmDetailModel.data!.comment!.add(Comment(
  //         id: apiResponse.body['data']['id'],
  //         comment: apiResponse.body['data']['comment'],
  //         user: confess == 1 ? 'Anonymous' : Get.find<AuthController>().userModel!.data!.name,
  //         createdAt: apiResponse.body['data']['created_at'],
  //         avatar: confess == 1 ? 'https://cinemagickh.oss-ap-southeast-7.aliyuncs.com/398790-PCT3BY-905.jpg' : Get.find<AuthController>().userModel!.data!.avatar
  //       ));
  //         _isLoding = false;
  //         update();
  //       }
  //       if(type == 3){
  //         // await Get.find<VideoController>().getVideoDetail(id);
  //         // var videoDetailModel = Get.find<VideoController>().videoDetail;
  //         // videoDetailModel.data!.comment!.addAll(apiResponse.body['data']);
  //       }
  //       _isLoding = false;
  //       showCustomDialog('thank_you_for_your_comment', Get.context!,isError: false);
  //       update();
  //       return 'OK';
  //     }  else {
  //       return apiResponse;
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  Future deleteComment({required int id, required int type, int? item_id}) async {
    try {
      Response apiResponse = await articalRepository.deleteComment(id: id);
      if (apiResponse.statusCode == 200) {

        if(type == 1) {
          _articalDetailModel['comment'].removeWhere((element) => element['id'] == id);
          update();
        }
        if(type == 2)
        {
          await Get.find<FilmController>().filmDetail(id: item_id!);
          var filmDetailModel = Get.find<FilmController>().movieDetailModel;
          filmDetailModel.data!.comment!.removeWhere((element) => element.id == item_id);
          update();
        }
        if(type == 3){
          // await Get.find<VideoController>().getVideoDetail(item_id!);
          // var videoDetailModel = Get.find<VideoController>().videoDetail;
          // videoDetailModel.data!.comment!.removeWhere((element) => element.id == item_id);
        }
        update();
        showCustomDialog('delete_comment_success', Get.context!,isError: false);

        update();
        return 'OK';
      } else {
        showCustomDialog('${apiResponse.body['message']}', Get.context!,isError: true);
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allSearch({required String search,String? mostWatch})async{
    try{
      Response apiResponse = await articalRepository.allSearch(search: search,mostWatch: mostWatch);
      if(apiResponse.statusCode == 200){
        _searchModel = SearchModel.fromJson(apiResponse.body);
        update();
        return apiResponse;
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  //Todo: favorite

  Future createFavorite({required int itemType, required int itemID}) async {
    try {
      Response apiResponse = await articalRepository.createFavorite(itemType: itemType, itemID: itemID);
      if (apiResponse.statusCode == 200) {
        checkNotify(id: itemID,type_id: itemType);
        _isFavorite = true;
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteFavorite({required int id}) async {
    try {
      Response apiResponse = await articalRepository.deleteFavorite(id: id);
      if (apiResponse.statusCode == 200) {
        _isFavorite = false;
        update();
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}