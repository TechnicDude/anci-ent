import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';

class HomelistPlayedSong {
  String? status;
  String? message;
  List<HomelistPlayedSongData>? homelistPlayedSongdata;

  HomelistPlayedSong({this.status, this.message, this.homelistPlayedSongdata});

  HomelistPlayedSong.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      homelistPlayedSongdata = <HomelistPlayedSongData>[];
      json['data'].forEach((v) {
        homelistPlayedSongdata!.add(new HomelistPlayedSongData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.homelistPlayedSongdata != null) {
      data['data'] =
          this.homelistPlayedSongdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomelistPlayedSongData {
  int? id;
  int? albumId;
  int? songId;
  int? userId;
  String? currentDate;
  String? currentTime;
  String? type;
  String? songCount;
  String? albumCount;
  String? createdAt;
  String? updatedAt;
  String? likes;
  String? paymentData;
  SongAlbumList? songs;

  HomelistPlayedSongData(
      {this.id,
      this.albumId,
      this.songId,
      this.userId,
      this.currentDate,
      this.currentTime,
      this.type,
      this.songCount,
      this.albumCount,
      this.createdAt,
      this.updatedAt,
      this.likes,
      this.paymentData,
      this.songs});

  HomelistPlayedSongData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumId = json['album_id'];
    songId = json['song_id'];
    userId = json['user_id'];
    currentDate = json['current_date'];
    currentTime = json['current_time'];
    type = json['type'];
    songCount = json['song_count'];
    albumCount = json['album_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likes = json['likes'];
    paymentData = json['payment_data'];
    songs = json['songs'] != null
        ? new SongAlbumList.fromJson(json['songs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['current_date'] = this.currentDate;
    data['current_time'] = this.currentTime;
    data['type'] = this.type;
    data['song_count'] = this.songCount;
    data['album_count'] = this.albumCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes'] = this.likes;
    data['payment_data'] = this.paymentData;
    if (this.songs != null) {
      data['songs'] = this.songs!.toJson();
    }
    return data;
  }
}
