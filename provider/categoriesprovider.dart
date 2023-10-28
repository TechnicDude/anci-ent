import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/model/couponlistModel.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/model/shopcardmodel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  AlbumsListModel albumsListModel = AlbumsListModel();
  ShopcartListModel shopcartListModel = ShopcartListModel();

  LanguageModelss languageModels = LanguageModelss();
  CouponListModel couponsModels = CouponListModel();

  List<AlbumData> _albumslist = [];
  List<AlbumData> get albumsList => _albumslist;

  List<SongAlbumList> _songlist = [];
  List<SongAlbumList> get songlist => _songlist;

  List<ShopcartListDataModel> _shopcardlist = [];
  List<ShopcartListDataModel> get shopcardList => _shopcardlist;

  List<LanguageModelsData> _languagelist = [];
  List<LanguageModelsData> get languageList => _languagelist;

  List<CouponListModelData> _couponcardlist = [];
  List<CouponListModelData> get couponcardList => _couponcardlist;

  int indexlamguage = 0;
  bool fetchdatalanguage = false;

  Future albumlist(String id, String languageid) async {
    var data = {"id": id, "user_id": MyApp.userid, "language_id": languageid};
    Service _service = new Service(APIURL.AlbumByCategory, data);
    final response = await _service.formdata();
    _albumslist = [];
    _songlist = [];
    albumsListModel = AlbumsListModel.fromJson(response);
    if (albumsListModel.albumdata != null) {
      if (albumsListModel.albumdata!.isNotEmpty) {
        _albumslist.addAll(albumsListModel.albumdata!);
      }
    }
    if (albumsListModel.songdata != null) {
      if (albumsListModel.songdata!.isNotEmpty) {
        _songlist.addAll(albumsListModel.songdata!);
      }
    }
    notifyListeners();
    return;
  }

  Future languagelist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.LanguageList);
    final response = await _service.data();

    languageModels = LanguageModelss.fromJson(response);
    if (languageModels.languageModelsdata != null) {
      if (languageModels.languageModelsdata!.isNotEmpty) {
        _languagelist = [];
        _languagelist.addAll(languageModels.languageModelsdata!);
        if (_languagelist.isNotEmpty) {
          indexlamguage = _languagelist[0].id!.toInt();
        }
      }
    }
    notifyListeners();
    return;
  }

  Future shopcard(String id) async {
    var data = {"id": MyApp.userid, "coupon_id": id};
    Service _service = new Service(APIURL.CartList, data);
    final response = await _service.formdata();
    _shopcardlist = [];
    shopcartListModel = ShopcartListModel.fromJson(response);
    if (shopcartListModel.data != null) {
      if (shopcartListModel.data!.isNotEmpty) {
        _shopcardlist.addAll(shopcartListModel.data!);
      }
    }
    notifyListeners();
    return;
  }

  Future coupon() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.CouponList);
    final response = await _service.data();
    _couponcardlist = [];
    couponsModels = CouponListModel.fromJson(response);
    if (couponsModels.data != null) {
      if (couponsModels.data!.isNotEmpty) {
        _couponcardlist.addAll(couponsModels.data!);
      }
    }
    notifyListeners();
    return;
  }
}
