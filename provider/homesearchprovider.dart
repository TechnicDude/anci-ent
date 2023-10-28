import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/model/homesearchModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';
import 'package:flutter/material.dart';

class HomesearchProvider extends ChangeNotifier {
  HomesearchModel homesearchModel = HomesearchModel();

  List<CategoriesData> _homesearchalldatacategory = [];
  List<CategoriesData> get homesearchalldatacategory =>
      _homesearchalldatacategory;

  List<ArtistData> _homesearchalldataartist = [];
  List<ArtistData> get homesearchalldataartist => _homesearchalldataartist;

  List<AlbumData> _homesearchalldataalbums = [];
  List<AlbumData> get homesearchalldataalbums => _homesearchalldataalbums;

  List<SongAlbumList> _homesearchalldatasong = [];
  List<SongAlbumList> get homesearchalldatasong => _homesearchalldatasong;

  bool datanotfound = false;

  Future albumlist(String namne) async {
    var data = {
      "name": namne,
    };
    Service _service = new Service(APIURL.HomeSearch, data);
    final response = await _service.formdata();

    homesearchModel = HomesearchModel.fromJson(response);
    _homesearchalldatacategory = [];
    if (homesearchModel.data != null) {
      if (homesearchModel.data!.category!.isNotEmpty) {
        for (int i = 0; i < homesearchModel.data!.category!.length; i++) {
          _homesearchalldatacategory.add(homesearchModel.data!.category![i]);
        }
      }
    }
    _homesearchalldataartist = [];
    if (homesearchModel.data != null) {
      if (homesearchModel.data!.artist!.isNotEmpty) {
        for (int i = 0; i < homesearchModel.data!.artist!.length; i++) {
          _homesearchalldataartist.add(homesearchModel.data!.artist![i]);
        }
      }
    }
    _homesearchalldataalbums = [];
    if (homesearchModel.data != null) {
      if (homesearchModel.data!.album!.isNotEmpty) {
        for (int i = 0; i < homesearchModel.data!.album!.length; i++) {
          _homesearchalldataalbums.add(homesearchModel.data!.album![i]);
        }
      }
    }
    _homesearchalldatasong = [];
    if (homesearchModel.data != null) {
      if (homesearchModel.data!.song!.isNotEmpty) {
        for (int i = 0; i < homesearchModel.data!.song!.length; i++) {
          _homesearchalldatasong.add(homesearchModel.data!.song![i]);
        }
      }
    }
    notifyListeners();
    return;
  }
}
