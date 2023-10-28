import 'dart:developer';

import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/model/addplaylistModel.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/bannerlistModel.dart';
import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/model/languageModels.dart';
import 'package:ancientmysticmusic/model/recentplaymodel.dart';
import 'package:ancientmysticmusic/model/shopcardmodel.dart';
import 'package:ancientmysticmusic/model/songlistByAlbumModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:flutter/material.dart';
import '../model/languageModels.dart';

class DashBoradProvider extends ChangeNotifier {
  BannerListModel bannerListModel = BannerListModel();
  CategoriesModel categoriesModel = CategoriesModel();
  AlbumsListModel albumsListModel = AlbumsListModel();
  ArtistListModel artistListModel = ArtistListModel();
  ShopcartListModel shopcartListModel = ShopcartListModel();
  HomelistPlayedSong songlistByAlbumModel = HomelistPlayedSong();
  LanguageModelss languageModels = LanguageModelss();
  AddListPlayModel addListPlayModel = AddListPlayModel();
  SonglistByAlbumModel singlesonglistByAlbumModel = SonglistByAlbumModel();

  List<BannerData> _bannerlist = [];
  List<BannerData> get bannerList => _bannerlist;

  List<CategoriesData> _categorieslist = [];
  List<CategoriesData> get categoriesList => _categorieslist;

  List<SongAlbumList> _siglesonglistlist = [];
  List<SongAlbumList> get siglesonglistlist => _siglesonglistlist;

  bool datanotfound = false;

  List<AlbumData> _albumslist = [];
  List<AlbumData> get albumsList => _albumslist;

  List<ArtistData> _artistlist = [];
  List<ArtistData> get artistList => _artistlist;

  List<HomelistPlayedSongData> _songartistlist = [];
  List<HomelistPlayedSongData> get songartistList => _songartistlist;

  List<ShopcartListDataModel> _shopcardlist = [];
  List<ShopcartListDataModel> get shopcardList => _shopcardlist;

  List<LanguageModelsData> _languagelist = [];
  List<LanguageModelsData> get languageList => _languagelist;

  List<ListPlayData> _addPlaylist = [];
  List<ListPlayData> get addPlayListList => _addPlaylist;

  int indexlamguage = 0;
  bool fetchdatalanguage = false;

  Future bannerlist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.BANNERLIST);
    final response = await _service.data();

    bannerListModel = BannerListModel.fromJson(response);
    if (bannerListModel.data != null) {
      if (bannerListModel.data!.isNotEmpty) {
        _bannerlist = [];
        for (int i = 0; i < bannerListModel.data!.length; i++) {
          _bannerlist.add(bannerListModel.data![i]);
        }
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
        for (int i = 0; i < languageModels.languageModelsdata!.length; i++) {
          _languagelist.add(languageModels.languageModelsdata![i]);
        }
        if (_languagelist.isNotEmpty) {
          indexlamguage = _languagelist[0].id!.toInt();
        }
      }
    }
    notifyListeners();
    return;
  }

  Future categorieslist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.CATEGORY);
    final response = await _service.data();

    categoriesModel = CategoriesModel.fromJson(response);
    if (categoriesModel.data != null) {
      if (categoriesModel.data!.isNotEmpty) {
        _categorieslist = [];
        for (int i = 0; i < categoriesModel.data!.length; i++) {
          _categorieslist.add(categoriesModel.data![i]);
        }
      }
    }
    notifyListeners();
    return;
  }

  Future albumlist(String languageid) async {
    fetchdatalanguage = false;

    _albumslist = [];

    var body = {"id": languageid, "user_id": MyApp.userid};

    Service _service = new Service(APIURL.ALBUMSLIST, body);
    final response = await _service.formdata();

    albumsListModel = AlbumsListModel.fromJson(response);

    if (albumsListModel.albumdata!.isNotEmpty) {
      log("message print");
      log(albumsListModel.albumdata!.length.toString());
      log("object");
      for (int i = 0; i < albumsListModel.albumdata!.length; i++) {
        log("object");
        log(albumsListModel.albumdata.toString());
        log(_albumslist.toString());
        _albumslist.add(albumsListModel.albumdata![i]);
        log(_albumslist.toString());
      }
    }
    log(_albumslist.length.toString());

    fetchdatalanguage = true;
    notifyListeners();
    return;
  }

  Future singleSonglist(String languageid) async {
    _siglesonglistlist = [];

    var body = {"id": languageid, "user_id": MyApp.userid};

    Service _service = new Service(APIURL.SINGLESONG, body);
    final response = await _service.formdata();

    singlesonglistByAlbumModel = SonglistByAlbumModel.fromJson(response);

    if (singlesonglistByAlbumModel.songalbumlist!.isNotEmpty) {
      _siglesonglistlist.addAll(singlesonglistByAlbumModel.songalbumlist!);
    }

    notifyListeners();
    return;
  }

  Future artistlist() async {
    ServiceWithoutbody _service = new ServiceWithoutbody(APIURL.ARTISTLIST);
    final response = await _service.data();

    artistListModel = ArtistListModel.fromJson(response);
    if (artistListModel.artistdata != null) {
      if (artistListModel.artistdata!.isNotEmpty) {
        _artistlist = [];
        for (int i = 0; i < artistListModel.artistdata!.length; i++) {
          _artistlist.add(artistListModel.artistdata![i]);
        }
      }
    }
    notifyListeners();
    return;
  }

  Future listPlayedSong() async {
    var data = {
      "id": MyApp.userid,
    };
    Service _service = new Service(APIURL.ListPlayedSong, data);
    final response = await _service.formdata();

    songlistByAlbumModel = HomelistPlayedSong.fromJson(response);
    if (songlistByAlbumModel.homelistPlayedSongdata != null) {
      if (songlistByAlbumModel.homelistPlayedSongdata!.isNotEmpty) {
        _songartistlist = [];
        for (int i = 0;
            i < songlistByAlbumModel.homelistPlayedSongdata!.length;
            i++) {
          _songartistlist.add(songlistByAlbumModel.homelistPlayedSongdata![i]);
        }
      }
    }
    notifyListeners();
    return;
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

  Future addPlayListCard() async {
    var data = {"id": MyApp.userid};
    Service _service = new Service(APIURL.AddPlaylistList, data);
    final response = await _service.formdata();
    _addPlaylist = [];
    addListPlayModel = AddListPlayModel.fromJson(response);
    if (addListPlayModel.listPlaydata != null) {
      if (addListPlayModel.listPlaydata!.isNotEmpty) {
        for (int i = 0; i < addListPlayModel.listPlaydata!.length; i++) {
          _addPlaylist.add(addListPlayModel.listPlaydata![i]);
        }
      }
    }
    notifyListeners();
    return;
  }
}
