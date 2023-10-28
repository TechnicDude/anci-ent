import 'package:ancientmysticmusic/model/StorelikebyuserModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';

class ShopcartListModel {
  String? status;
  String? message;
  List<ShopcartListDataModel>? data;
  double? totalPrice;

  ShopcartListModel({this.status, this.message, this.data, this.totalPrice});

  ShopcartListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ShopcartListDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ShopcartListDataModel.fromJson(v));
      });
    }
    totalPrice = double.parse(json['totalPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

class ShopcartListDataModel {
  int? id;
  int? albumId;
  String? songId;
  int? userId;
  double? price;
  String? createdAt;
  String? updatedAt;
  SongAlbumList? songs;
  Albums? albums;

  ShopcartListDataModel(
      {this.id,
      this.albumId,
      this.songId,
      this.userId,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.songs,
      this.albums});

  ShopcartListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumId = json['album_id'];
    songId = json['song_id'].toString();
    userId = json['user_id'];
    price = double.parse(json['price'].toString() ?? '');
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    songs = json['songs'] != null
        ? new SongAlbumList.fromJson(json['songs'])
        : null;
    albums =
        json['albums'] != null ? new Albums.fromJson(json['albums']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['songs'] = this.songs;
    if (this.songs != null) {
      data['songs'] = this.songs!.toJson();
    }
    if (this.albums != null) {
      data['albums'] = this.albums!.toJson();
    }
    return data;
  }
}
