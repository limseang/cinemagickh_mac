
import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/data/api/api_client.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilRepository {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  UtilRepository({
    required this.dioClient,
    required this.sharedPreferences,
  });

  Future countUser() async {
    try {
      final response = dioClient.getData(AppConstants.countUser);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future getFilmType() async {
    try {
      final response = dioClient.getData(AppConstants.tag);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCategory() async {
    try {
      final response = dioClient.getData(AppConstants.allCategory);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allType() async {
    try {
      final response = dioClient.getData(AppConstants.allType);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCountry() async {
    try {
      final response = dioClient.getData(AppConstants.allCountry);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCinema() async {
    try {
      final response = dioClient.getData(AppConstants.allCinema);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allArtist({required int page}) async {
    try {
      final response = dioClient.getData('${AppConstants.allArtist}?page=$page');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future artistDetail({required int id}) async {
    try {
      final response = dioClient.getData('${AppConstants.artistDetail}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future allArtistByFilm({required int id}) async {
    try {
      final response = dioClient.getData('${AppConstants.allArtistByFilm}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future castDetail({required int id}) async {
    try {
      final response = dioClient.getData('${AppConstants.castDetail}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


  Future allGift() async {
    try {
      final response = dioClient.getData(AppConstants.giftList);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future giftDetail({required int id}) async {
    try {
      final response = dioClient.getData('${AppConstants.giftDetail}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future giftRedeem({required int id,required String phoneNumber}) async {
    try {
      final response = dioClient.postData(AppConstants.giftRedeem, {
        "gift_id": id,
        "phone_number": phoneNumber,
        "status": "1",
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future OwnRandomHistory() async {
    try {
      final response = dioClient.getData(AppConstants.OwnRandomHistory);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future OwnRandomDetail({required int id}) async {
    try {
      final response = dioClient.getData('${AppConstants.OwnRandomDetail}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future cancelRandom({required int id}) async {
    try {
      final response = dioClient.postData('${AppConstants.cancelRandom}$id',{});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future confirmRandom({required int id}) async {
    try {
      final response = dioClient.postData('${AppConstants.confirmRandom}$id',{});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


  // Todo : Post Permission

  Future newFilm(
      {required String title, required String description, required String release_date, required String categoryID, required String tagID, required XFile poster, required XFile cover, required String trailer, required String typeID, required String countryID, required String running_time}) async {
    try {
      final response = dioClient.postMultipartData(AppConstants.newFilm, {
        "title": title,
        "overview": description,
        "release_date": release_date,
        "category": categoryID,
        "tag": tagID,
        "trailer": trailer,
        "type": typeID,
        "language": countryID,
        "running_time": running_time,
      }, [
        MultipartBody('poster', poster),
        MultipartBody('cover', cover),
      ]);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }



  Future newEpisode(
      {required String title, required String description, required String release_date, required String film_id, required String episode, required XFile poster, required String file, required String season, required int notification }) async {
    try {
      final response = dioClient.postMultipartData('${AppConstants.newEpisode}', {
        "title": title,
        "description": description,
        "episode": episode,
        "season": season,
        "release_date": release_date,
        "film_id": film_id,
        "file" : file,
        "notification" : notification.toString(),
      }, [
        MultipartBody('poster', poster),
      ]);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteArticle({required int id}) async {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteArticle}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future addCinemaToFilm({required int filmID, required int cinemaID}) async {
    try {
      final response = dioClient.postData(AppConstants.addCinemaToFilm, {
        "film_id": filmID,
        "available_id": cinemaID,
      });
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future newVideo({
    required String title,
    required String description,
    required String link,
    required XFile cover,
    required String running_time,
    required String typeID,
    required String categoryID,
    required String tagID,
  }) async {
    try {
      final response = dioClient.postMultipartData(AppConstants.newVideo, {
        "title": title,
        "description": description,
        "video_url": link,
        "running_time": running_time,
        "type_id": typeID,
        "category_id": categoryID,
        "tag_id": tagID,
        "status": "1",
      }, [
        MultipartBody('cover_image_url', cover),
      ]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future newArtist(
      {required String name, required String biography, required XFile profile, required String dob, String? dod, required String nationality, required String knownFor, required String gender}) async {
    try {
      final response = dioClient.postMultipartData(AppConstants.newArtist, {
        "name": name,
        "birth_date": dob,
        dod ?? "death_date": dod!,
        "nationality": nationality,
        "biography": biography,
        "know_for": knownFor,
        "gender": gender,
        "status": "1",
      }, [
        MultipartBody('profile', profile),
      ]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteFilm({required int id}) async {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteFilm}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future addArtistToFilm(
      {required String filmID, required String artistID, required String character, required String position, required XFile image}) async {
    try {
      final response = dioClient.postMultipartData(
          AppConstants.addArtistToFilm, {
        "film_id": filmID,
        "actor_id": artistID,
        "character": character,
        "position": position,
        "status": "1",
      }, [
        MultipartBody('image', image),
      ]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future editCast({required String id, required String character, required String position,  XFile? image,required String film_id, required String actor_id}) async {
    try {
      final response = dioClient.postMultipartData(
          '${AppConstants.editCast}$id', {
        "film_id": film_id,
        "actor_id": actor_id,
        "character": character,
        "position": position,
        "status": "1",
      }, [
        if (image != null) MultipartBody('image', image),
      ]);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCast({required String id}) async {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteCast}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }


  Future editArtist({required String id, required String name, required String biography,  XFile? profile, required String dob, String? dod,required String nationality, required String knownFor, required String gender})
  {
    try{
      final response = dioClient.postMultipartData('${AppConstants.editArtist}$id',
          {
            "name": name,
            "birth_date": dob,
            dod ?? "death_date": dod!,
            "nationality": nationality,
            "biography": biography,
            "know_for": knownFor,
            "gender": gender,
            "status": "1",},
          [
            if(profile != null) MultipartBody('profile', profile),
          ]);
      return response;
    }
    catch(e){
      throw e.toString();
    }

  }

  Future deleteArtist({required String id}) async {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteArtist}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }

    }

  Future allCinemaInFilm({required String id}) async {
    try {
      final response = dioClient.getData('${AppConstants.allCinemaFilm}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCinemaFilm({required String id}) async {
    try {
      final response = dioClient.deleteData('${AppConstants.deleteCinemaFilm}$id');
      return response;
    } catch (e) {
      throw e.toString();
    }
  }



}