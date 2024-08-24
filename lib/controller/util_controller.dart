

import 'package:miss_planet/controller/auth_controller.dart';

import 'package:miss_planet/data/model/TagModel.dart';
import 'package:miss_planet/data/model/artistDetailModel.dart';
import 'package:miss_planet/data/model/artistModel.dart';
import 'package:miss_planet/data/model/castDetailModel.dart';
import 'package:miss_planet/data/model/categoryModel.dart';
import 'package:miss_planet/data/model/countryModel.dart';
import 'package:miss_planet/data/model/giftDetailModel.dart';
import 'package:miss_planet/data/model/giftModel.dart';
import 'package:miss_planet/data/model/ownRandomModel.dart';
import 'package:miss_planet/data/model/typeModel.dart';
import 'package:miss_planet/data/repository/util_repositiory.dart';

import 'package:miss_planet/util/next_screen.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilController extends GetxController implements GetxService {
  final UtilRepository utilRepository;
  final SharedPreferences sharedPreferences;

  UtilController(
      {required this.utilRepository, required this.sharedPreferences}) {}

  //set
  TagModel _tagModel = TagModel();
  CategoryModel _categoryModel = CategoryModel();
  TypeModel _typeModel = TypeModel();
  CountryModel _countryModel = CountryModel();
  ArtistDetailModel _artistDetailModel = ArtistDetailModel();
  CastDetailModel _castDetailModel = CastDetailModel();

  List<ArtistDetailModel2>? _artistModel;
  GiftModel _giftModel = GiftModel();
  GiftDetailModel _giftDetailModel = GiftDetailModel();
  OwnRandomlModel _ownRandomlModel = OwnRandomlModel();
  List _cinemaList = [];
  List _cinemaFilmList = [];
  List _artistByFilmList = [];
  List<dynamic> _tagList = [];
  Map<String, dynamic>? _ownRandomDetail;


  String _selectedCategory = 'Category';
  String _selectedType = 'Type';
  String _selectedTag = 'Tag';
  String _selectedCountry = 'Country';
  String _selectArtist = 'Artist';
  int? _allUser;

  int _selectedCategoryId = 0;
  int _selectedTypeId = 0;
  int _selectedTagId = 0;
  int _selectedCountryId = 0;
  int _selectArtistId = 0;
  int? _currentPageAllArtist;
  int? _totalCountAllArtist;
  int? _last_pageAllArtist;

  bool _isLoadMore = false;
  int _page = 1;



  int _index = 0;


  //get
  GiftModel get giftModel => _giftModel;

  GiftDetailModel get giftDetailModel => _giftDetailModel;

  OwnRandomlModel get ownRandomModel => _ownRandomlModel;

  TagModel get tagModel => _tagModel;

  CategoryModel get categoryModel => _categoryModel;

  TypeModel get typeModel => _typeModel;

  ArtistDetailModel get artistDetailModel => _artistDetailModel;

  List<ArtistDetailModel2>? get artistModel => _artistModel;

  List<dynamic> get tagList => _tagList;

  Map<String, dynamic>? get ownRandomDetail => _ownRandomDetail;

  CountryModel get countryModel => _countryModel;

  List get cinemaList => _cinemaList;

  List get cinemaFilmList => _cinemaFilmList;

  List get artistByFilmList => _artistByFilmList;

  CastDetailModel get castDetailModel => _castDetailModel;

  String get selectedCategory => _selectedCategory;

  String get selectedType => _selectedType;

  String get selectedTag => _selectedTag;

  String get selectedCountry => _selectedCountry;

  String get selectArtist => _selectArtist;

  int get selectedCategoryId => _selectedCategoryId;

  int get selectedTypeId => _selectedTypeId;

  int get selectedTagId => _selectedTagId;

  int get selectedCountryId => _selectedCountryId;

  int get selectArtistId => _selectArtistId;

  int? get currentPageAllArtist => _currentPageAllArtist;
  int? get totalCountArtist => _totalCountAllArtist;
  int? get last_pageAllArtist => _last_pageAllArtist;
  bool get isLoadMore => _isLoadMore;
  int get page => _page;
  int? get allUser => _allUser;




  int get index => _index;

  setIndex(int value) {
    _index = value;
    update();
  }



  setSelectedCategory(String value, int id) {
    _selectedCategory = value;
    _selectedCategoryId = id;
    update();
  }

  setSelectedType(String value, int id) {
    _selectedType = value;
    _selectedTypeId = id;
    update();
  }

  setSelectedTag(String value, int id) {
    _selectedTag = value;
    _selectedTagId = id;
    update();
  }

  setSelectedCountry(String value, int id) {
    _selectedCountry = value;
    _selectedCountryId = id;
    update();
  }

  setSelectArtist(String value, int id) {
    _selectArtist = value;
    _selectArtistId = id;
    update();
  }


  setPage() {
    _page = _page + 1;
    update();
  }
  setLoadMore(bool loadMore) {
    _isLoadMore = loadMore;
    update();
  }

  Future getFilmType() async {
    try {
      Response apiResponse = await utilRepository.getFilmType();
      if (apiResponse.statusCode == 200 &&
          apiResponse.body['message'] == 'success') {
        _tagList = apiResponse.body['data'];
        _tagModel = TagModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCategory() async {
    try {
      Response apiResponse = await utilRepository.allCategory();
      if (apiResponse.statusCode == 200) {
        _categoryModel = CategoryModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allType() async {
    try {
      Response apiResponse = await utilRepository.allType();
      if (apiResponse.statusCode == 200) {
        _typeModel = TypeModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCountry() async {
    try {
      Response apiResponse = await utilRepository.allCountry();
      if (apiResponse.statusCode == 200) {
        _countryModel = CountryModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allCinema() async {
    try {
      Response apiResponse = await utilRepository.allCinema();
      if (apiResponse.statusCode == 200) {
        _cinemaList = apiResponse.body['data'];
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allArtist() async {
   if(_page == 1 ){
     _artistModel = null;
     update();
   }
    try {
      Response apiResponse = await utilRepository.allArtist(page: _page);
      if (apiResponse.statusCode == 200) {

       if(_page == 1) {

         _artistModel = [];
         update();
         _totalCountAllArtist = apiResponse.body['data']['total'];
         _last_pageAllArtist = apiResponse.body['data']['last_page'];
          _currentPageAllArtist = apiResponse.body['data']['current_page'];
         apiResponse.body['data']['data'].forEach((key,value){
           value.forEach((element) {
             _artistModel!.add(ArtistDetailModel2.fromJson(element));
             _isLoadMore = false;
             update();
           });
         });

       }
       else {
         _isLoadMore = true;
          //keep old data and add new data
          apiResponse.body['data']['data'].forEach((key,value){
            value.forEach((element) {
              _artistModel!.add(ArtistDetailModel2.fromJson(element));
              _isLoadMore = false;
              update();
            });
            update();
          });

       }


        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future artistDetail({required int id}) async {
    try {
      Response apiResponse = await utilRepository.artistDetail(id: id);
      if (apiResponse.body['code'] == 200) {
        _artistDetailModel = ArtistDetailModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future artistByFilm({required int id}) async {
    try {
      Response apiResponse = await utilRepository.allArtistByFilm(id: id);
      if (apiResponse.statusCode == 200) {
        _artistByFilmList = apiResponse.body['data'];
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getCastDetail({required int id}) async {
    try {
      Response apiResponse = await utilRepository.castDetail(id: id);
      if (apiResponse.statusCode == 200) {
        _castDetailModel = CastDetailModel.fromJson(apiResponse.body);
        update();

        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future allGift()async{
    try{
      Response apiResponse = await utilRepository.allGift();
      if(apiResponse.statusCode == 200){
        _giftModel = GiftModel.fromJson(apiResponse.body);
        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future giftDetail({required int id})async{
    try{
      Response apiResponse = await utilRepository.giftDetail(id: id);
      if(apiResponse.statusCode == 200){
        _giftDetailModel = GiftDetailModel.fromJson(apiResponse.body);
        // nextScreen(Get.context, GiftDetailScreen(id: id,));
        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future redeemGift({required int id,required String phoneNumber})async{
    try{
      Response apiResponse = await utilRepository.giftRedeem(id: id,phoneNumber: phoneNumber);
      if(apiResponse.statusCode == 200 && apiResponse.body['status'] == true){
        Get.find<AuthController>().userInfo(fromGift:true);
        update();
        return 'ok';
      }
      else if(apiResponse.statusCode == 200 && apiResponse.body['message'] == 'Point is not enough'){
        return 'Point is not enough';
      }
      else if (apiResponse.statusCode == 200 && apiResponse.body['message'] == 'Gift is Empty'){
        return 'Gift is out of stock';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future OwnRandomHistory()async{
    try{
      Response apiResponse = await utilRepository.OwnRandomHistory();
      if(apiResponse.statusCode == 200){
        _ownRandomlModel = OwnRandomlModel.fromJson(apiResponse.body);

        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future OwnRandomDetail({required int id})async{
    try{
      Response apiResponse = await utilRepository.OwnRandomDetail(id: id);
      if(apiResponse.statusCode == 200){
        _ownRandomDetail = apiResponse.body['data'];
        if(_ownRandomDetail!['expired_date'] == null){
         showCustomDialog('ការដូររបស់អ្នកត្រូវបានផុតកំណត់បាត់ហើយ', Get.context!);
        }
       else{
          // nextScreen(Get.context, OwnRandomDetailScreen(id: id,));
        }

        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future cancelRandom ({required int id})async{
    try{
      Response apiResponse = await utilRepository.cancelRandom(id: id);
      if(apiResponse.statusCode == 200){
        OwnRandomHistory();
        Get.find<AuthController>().userInfo(fromGift:true);
        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  Future confirmRandom ({required int id})async{
    try{
      Response apiResponse = await utilRepository.confirmRandom(id: id);
      if(apiResponse.statusCode == 200){
        OwnRandomHistory();
        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }




  //Todo : Post Permission

  Future newFilm({required String title, required String description, required String release_date, required String categoryID, required String tagID, required XFile poster, required XFile cover, required String trailer, required String typeID, required String countryID, required String running_time})
  async {
    try {
      Response apiResponse = await utilRepository.newFilm(title: title,
          description: description,
          release_date: release_date,
          categoryID: categoryID,
          tagID: tagID,
          poster: poster,
          cover: cover,
          trailer: trailer,
          typeID: typeID,
          countryID: countryID,
          running_time: running_time);
      if (apiResponse.statusCode == 200) {
        print(apiResponse.body);
        update();
        return 'ok';
      }
      else {
        print(apiResponse.body);
        return 'error';
      }
    } catch (e) {
      throw e.toString();
    }
  }



  Future newEpisode ({required String title, required String description, required String release_date, required String film_id, required String episode, required XFile poster, required String file, required String season, required int notification })
  async{
    try {
      Response apiResponse = await utilRepository.newEpisode(title: title,
          description: description,
          release_date: release_date,
          film_id: film_id,
          episode: episode,
          poster: poster,
          file: file,
          notification: notification,
          season: season);
      if (apiResponse.statusCode == 200) {
        // Get.find<FilmController>().getFilm();
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

  Future deleteArticle({required int id}) async {
    try {
      Response apiResponse = await utilRepository.deleteArticle(id: id);
      if (apiResponse.statusCode == 200) {
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future addCinemaToFilm({required int filmID, required int cinemaID}) async {
    try {
      Response apiResponse = await utilRepository.addCinemaToFilm(
          filmID: filmID, cinemaID: cinemaID);
      if (apiResponse.statusCode == 200) {
        // Get.find<FilmController>().filmDetail(id: filmID);
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
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
      Response apiResponse = await utilRepository.newVideo(
        title: title,
        description: description,
        link: link,
        cover: cover,
        running_time: running_time,
        typeID: typeID,
        categoryID: categoryID,
        tagID: tagID,
      );
      if (apiResponse.statusCode == 200) {
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future newArtist(
      {required String name, required String biography, required XFile profile, required String dob, String? dod, required String nationality, required String knownFor, required String gender}) async
  {
    try {
      Response apiResponse = await utilRepository.newArtist(
        name: name,
        biography: biography,
        profile: profile,
        dob: dob,
        nationality: nationality,
        knownFor: knownFor,
        gender: gender,
        dod: dod == null ? null : dod,
      );
      if (apiResponse.statusCode == 200) {
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future deleteFilm({required int id}) async {
    try {
      Response apiResponse = await utilRepository.deleteFilm(id: id);
      if (apiResponse.statusCode == 200) {
        // Get.find<FilmController>().getFilm();
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future addArtistToFilm(
      {required String filmID, required String artistID, required String character, required String position, required XFile image}) async {
    try {
      Response apiResponse = await utilRepository.addArtistToFilm(
          filmID: filmID,
          artistID: artistID,
          character: character,
          position: position,
          image: image);
      if (apiResponse.statusCode == 200) {
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future editCast(
      {required String id, required String character, required String position, XFile? image, required String film_id, required String actor_id}) async {
    try {
      Response apiResponse = await utilRepository.editCast(id: id,
          character: character,
          position: position,
          image: image,
          film_id: film_id,
          actor_id: actor_id);
      if (apiResponse.statusCode == 200) {
        // Get.find<FilmController>().filmDetail(id: int.parse(film_id));
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future deleteCast({required String id}) async {
    try {
      Response apiResponse = await utilRepository.deleteCast(id: id);
      if (apiResponse.statusCode == 200) {
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future editArtist(
      {required String id, required String name, required String biography, XFile? profile, required String dob, String? dod, required String nationality, required String knownFor, required String gender}) async {
    try {
      Response apiResponse = await utilRepository.editArtist(id: id,
        name: name,
        biography: biography,
        dob: dob,
        nationality: nationality,
        knownFor: knownFor,
        gender: gender,
        profile: profile,
        dod: dod == null ? null : dod,);
      if (apiResponse.statusCode == 200) {
        artistDetail(id: int.parse(id));
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future deleteArtist({required String id}) async {
    try {
      Response apiResponse = await utilRepository.deleteArtist(id: id);
      if (apiResponse.statusCode == 200) {
        allArtist();
        update();
        return 'ok';
      }
      else {
        return 'error';
      }
    }
    catch (e) {
      throw e.toString();
    }
  }

  Future allCinemaFilm({required String id}) async {
    try {
      Response apiResponse = await utilRepository.allCinemaInFilm(id: id);
      if (apiResponse.statusCode == 200) {
        _cinemaFilmList = apiResponse.body['data'];
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future deleteCinemaFilm({required String id}) async {
    try {
      Response apiResponse = await utilRepository.deleteCinemaFilm(id: id);
      if (apiResponse.statusCode == 200) {
        allCinemaFilm(id: id);
        update();
        return 'ok';
      }
      else {
        return apiResponse;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future countUser()async{
    try{
      Response apiResponse = await utilRepository.countUser();
      if(apiResponse.statusCode == 200){
        _allUser = apiResponse.body['data'];
        update();
        return 'ok';
      }
      else{
        return apiResponse;
      }
    }
    catch(e){
      throw e.toString();
    }
  }


}
