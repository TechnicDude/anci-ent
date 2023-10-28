import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';

class HomesearchModel {
  String? status;
  String? message;
  HomesearchData? data;

  HomesearchModel({this.status, this.message, this.data});

  HomesearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new HomesearchData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomesearchData {
  List<CategoriesData>? category;
  List<ArtistData>? artist;
  List<AlbumData>? album;
  List<SongAlbumList>? song;

  HomesearchData({this.category, this.artist, this.album, this.song});

  HomesearchData.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <CategoriesData>[];
      json['category'].forEach((v) {
        category!.add(new CategoriesData.fromJson(v));
      });
    }
    if (json['artist'] != null) {
      artist = <ArtistData>[];
      json['artist'].forEach((v) {
        artist!.add(new ArtistData.fromJson(v));
      });
    }
    if (json['album'] != null) {
      album = <AlbumData>[];
      json['album'].forEach((v) {
        album!.add(new AlbumData.fromJson(v));
      });
    }
    if (json['song'] != null) {
      song = <SongAlbumList>[];
      json['song'].forEach((v) {
        song!.add(new SongAlbumList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.artist != null) {
      data['artist'] = this.artist!.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    if (this.song != null) {
      data['song'] = this.song!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
