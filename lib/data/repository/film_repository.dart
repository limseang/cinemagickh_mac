import 'dart:async';


import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FilmRepository {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FilmRepository({required this.dioClient, required this.sharedPreferences});

  Future getFilm({required int page}) {
    try {
      final response = dioClient.getData('${AppConstants.film}?page=$page');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future increaseView({required int id}) {
    try {
      final response = dioClient.postData('${AppConstants.increaseView}$id', {});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getHomeApi() {
    try {
      final response = dioClient.getData('${AppConstants.homeAPI}');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future editFilm(
      {required String title, required String description, required String release_date,  XFile? poster,  XFile? cover, required String trailer,  required String running_time, required int id}) async {
    try {
      final response = dioClient.postMultipartData('${AppConstants.editFilm}/$id', {
        "title": title,
        "overview": description,
        "release_date": release_date,
        "trailer": trailer,
        "running_time": running_time,
      }, [
        if (poster != null) MultipartBody('poster', poster),
        if (cover != null) MultipartBody('cover', cover),
      ]);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future filmDetail({required int id}) {
    try {
      final response = dioClient.getData('${AppConstants.filmDetail}/$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future watchMovieList({required int page}) {
    try{
      final response = dioClient.getData('${AppConstants.watchMovieList}?page=$page');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future searchMovie({required String search}) {
    try {
      final response = dioClient.postData(AppConstants.searchMovie, {
        "title": search,
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }



  Future rateFilm({required int id, required String rating}) {
    try {
      final response = dioClient.postData(AppConstants.rate, {
        'film_id': id,
        'rate': rating
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future shareFilm({required int id}) {
    try {
      final response = dioClient.postData("${AppConstants.shareFilm}/$id", {});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future requestFilm({required String title, required String link, required String description, required XFile image,required String noted}) {
    try {
      final response = dioClient.postMultipartData(AppConstants.requestFilm,{
        'film_name': title,
        'film_link': link,
        'film_description': description,
        'noted': noted
      }, [
        MultipartBody('film_image', image),
      ]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getFilmRequest() {
    try {
      final response = dioClient.getData(AppConstants.requestList);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future shotByRate({required String page, bool watch = false}) {
    try {
      final response = dioClient.getData('${AppConstants.shotByRate}?page=$page&watch=$watch');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future comingSoon() {
    try {
      final response = dioClient.getData(AppConstants.comingSoon);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future addCategory({required String categoryId, required String filmID}) {
    try {
      final response = dioClient.postData(AppConstants.addCategory, {
        'film_id' : filmID,
        'category_id' : categoryId
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getGenre () {
    try {
      final response = dioClient.getData(AppConstants.genre);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCategory({required String id}) {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteCategory}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future changeFilmType({required String id, required String typeID}) async {
    try {
      final response = dioClient.postData('${AppConstants.changeFilmType}$id', {
        "type": typeID,
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future addGenreToFilm({required String genreID, required String filmID}) async {
    try {
      final response = dioClient.postData(AppConstants.addGenreToFilm, {
        "film_id": filmID,
        "genre_id": genreID
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //  Subtitle

  Future getSubtitle({required int id}) {
    try {
      final response = dioClient.getData('${AppConstants.subtitleByEpisode}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


}