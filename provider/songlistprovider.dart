import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/model/profileuserModel.dart';
import 'package:ancientmysticmusic/model/shopcardmodel.dart';
import 'package:ancientmysticmusic/model/songlistByAlbumModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:flutter/material.dart';

class SongListProvider extends ChangeNotifier {
  SonglistByAlbumModel songlistByAlbumModel = SonglistByAlbumModel();
  SongListByArtistModel songListByArtistModel = SongListByArtistModel();

  LanguageModelss languageModels = LanguageModelss();

  ShopcartListModel shopcartListModel = ShopcartListModel();

  List<SongAlbumList> _songlistlist = [];
  List<SongAlbumList> get songlistList => _songlistlist;

  List<SongAlbumList> _songlistbyartistlist = [];
  List<SongAlbumList> get songlistbyartistList => _songlistbyartistlist;
  List<LanguageModelsData> _languagelist = [];
  List<LanguageModelsData> get languageList => _languagelist;

  List<ShopcartListDataModel> _shopcardlist = [];
  List<ShopcartListDataModel> get shopcardList => _shopcardlist;

  int indexlamguage = 0;
  bool fetchdatalanguage = false;

  Future songlistlist(String id, String languageid) async {
    var data = {"id": id, "user_id": MyApp.userid, "language_id": languageid};
    Service _service = new Service(APIURL.SONGLISTByAlbum, data);
    final response = await _service.formdata();

    _songlistlist = [];
    songlistByAlbumModel = SonglistByAlbumModel.fromJson(response);
    if (songlistByAlbumModel.songalbumlist != null) {
      _songlistlist.addAll(songlistByAlbumModel.songalbumlist!);
    }
    notifyListeners();
  }

  Future languagelist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.LanguageList);
    final response = await _service.data();
    _languagelist = [];

    languageModels = LanguageModelss.fromJson(response);
    if (languageModels.languageModelsdata != null) {
      if (languageModels.languageModelsdata!.isNotEmpty) {
        _languagelist.addAll(languageModels.languageModelsdata!);

        if (_languagelist.isNotEmpty) {
          indexlamguage = _languagelist[0].id!.toInt();
        }
      }
    }
    notifyListeners();
    return;
  }

  Future songlistbyartist(String id, String userid, String languageid) async {
    var data = {"id": id, "user_id": userid, "language_id": languageid};
    Service _service = new Service(APIURL.SongListByArtist, data);
    final response = await _service.formdata();

    _songlistbyartistlist = [];
    songListByArtistModel = SongListByArtistModel.fromJson(response);
    if (songListByArtistModel.songlistbyartistdata != null) {
      if (songListByArtistModel.songlistbyartistdata!.isNotEmpty) {
        _songlistbyartistlist
            .addAll(songListByArtistModel.songlistbyartistdata!);
      }
    }
    notifyListeners();
  }

  Future shopcard() async {
    var data = {"id": MyApp.userid};
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
}
