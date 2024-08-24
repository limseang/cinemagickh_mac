
import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticalRepository {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ArticalRepository({required this.dioClient, required this.sharedPreferences});


  Future getArtical({required int page}) {
    try {
      final response = dioClient.getData('${AppConstants.artical}?page=$page');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getArticalDetail({required int id}) {
    try {
      final response = dioClient.getData(
          AppConstants.articalDetail + id.toString());
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


  Future shareArticle({required int id}) {
    try {
      final response = dioClient.postData("${AppConstants.shareArticle}/$id", {});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future makeNotify({required int postType, required int postID}) {
    try {
      final response = dioClient.postData(AppConstants.notify , {
        "post_type": postType,
        "post_id": postID
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteNotify({required int postID, required int postType})async{
    try{
      final response = dioClient.postData("${AppConstants.UnNotify}",{
        "post_id": postID,
        "post_type": postType
      });
      return response;
    }
    catch(e){
      throw e.toString();
    }
  }

  Future checkNotify({required int id,required int type_id})async{
    try{
      final response = dioClient.postData("${AppConstants.checkNotify}$id",{
        "type_id": type_id
      });
      return response;
    }
    catch(e){
      throw e.toString();
    }
  }

  Future likeArticle({required int id})async{
    try{
      final response = dioClient.postData(AppConstants.likeArticle,{
        "artical_id": id
      });
      return response;
    }
    catch(e){
      throw e.toString();
    }
  }

  //Todo: comment

  Future createComment({required int id, required String comment, required int type,required int confess}) {
    try {
      final response = dioClient.postData(
          AppConstants.comment,
          {
            "item_id": id,
            "comment": comment,
            "type": type,
            "confess": confess
          });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteComment({required int id}) {
    try {
      final response = dioClient.deleteData(AppConstants.deleteComment + id.toString());
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allSearch({required String search, String? mostWatch})async{
    try{
      final response = dioClient.postData(AppConstants.search,{
        "title": search,
        "most_watch": mostWatch
      });
      return response;
    }
    catch(e){
      throw e.toString();
    }
  }

  Future createFavorite({required int itemType, required int itemID}) async {
    try {
      final response = await dioClient.postData(AppConstants.favoriteAdd, {
        "item_type": itemType,
        "item_id" : itemID
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteFavorite({required int id}) async {
    try {
      final response = await dioClient.deleteData(AppConstants.favoriteDelete + id.toString());
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


}


