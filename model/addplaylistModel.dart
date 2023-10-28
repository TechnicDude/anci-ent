import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';

class AddListPlayModel {
  String? status;
  String? message;
  List<ListPlayData>? listPlaydata;

  AddListPlayModel({this.status, this.message, this.listPlaydata});

  AddListPlayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listPlaydata = <ListPlayData>[];
      json['data'].forEach((v) {
        listPlaydata!.add(new ListPlayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.listPlaydata != null) {
      data['data'] = this.listPlaydata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListPlayData {
  int? id;
  String? name;
  String? albumId;
  int? songId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? likes;
  String? paymentData;
  AlbumData? albums;
  SongAlbumList? songs;

  ListPlayData(
      {this.id,
      this.name,
      this.albumId,
      this.songId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.likes,
      this.paymentData,
      this.albums,
      this.songs});

  ListPlayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    albumId = json['album_id'];
    songId = json['song_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likes = json['likes'];
    paymentData = json['payment_data'];

    albums =
        json['albums'] != null ? new AlbumData.fromJson(json['albums']) : null;
    songs = json['songs'] != null
        ? new SongAlbumList.fromJson(json['songs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes'] = this.likes;
    data['payment_data'] = this.paymentData;

    if (this.albums != null) {
      data['albums'] = this.albums!.toJson();
    }
    if (this.songs != null) {
      data['songs'] = this.songs!.toJson();
    }
    return data;
  }
}
