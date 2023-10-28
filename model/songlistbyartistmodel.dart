import 'package:ancientmysticmusic/model/songalbummodel.dart';

class SongListByArtistModel {
  String? status;
  String? message;
  List<SongAlbumList>? songlistbyartistdata;

  SongListByArtistModel({this.status, this.message, this.songlistbyartistdata});

  SongListByArtistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      songlistbyartistdata = <SongAlbumList>[];
      json['data'].forEach((v) {
        songlistbyartistdata!.add(new SongAlbumList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.songlistbyartistdata != null) {
      data['data'] = this.songlistbyartistdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongAlbumList {
  int? id;
  int? languageId;
  int? albumId;
  int? artistId;
  String? title;
  String? mp3Link;
  String? image;
  String? downloadOption;
  String? lyrics;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? audio;
  String? price;
  String? paymentStatus;
  String? likes;
  String? paymentdata;
  Languages? languages;
  Artists? artists;
  Albums? albums;

  SongAlbumList(
      {this.id,
      this.languageId,
      this.albumId,
      this.artistId,
      this.title,
      this.mp3Link,
      this.image,
      this.downloadOption,
      this.lyrics,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.audio,
      this.price,
      this.paymentStatus,
      this.likes,
      this.paymentdata,
      this.languages,
      this.artists,
      this.albums});

  SongAlbumList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    albumId = json['album_id'];
    artistId = json['artist_id'];
    title = json['title'];
    mp3Link = json['mp3_link'];
    image = json['image'];
    downloadOption = json['download_option'];
    lyrics = json['lyrics'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'].toString();
    audio = json['audio'];
    price = json['price'].toString();
    paymentdata = json['payment_data'];
    paymentStatus = json['payment_status'];
    likes = json['likes'];
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
    artists =
        json['artists'] != null ? new Artists.fromJson(json['artists']) : null;
    albums =
        json['albums'] != null ? new Albums.fromJson(json['albums']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['album_id'] = this.albumId;
    data['artist_id'] = this.artistId;
    data['title'] = this.title;
    data['mp3_link'] = this.mp3Link;
    data['image'] = this.image;
    data['download_option'] = this.downloadOption;
    data['lyrics'] = this.lyrics;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['audio'] = this.audio;
    data['price'] = this.price;
    data['payment_status'] = this.paymentStatus;
    data['likes'] = this.likes;
    data['payment_data'] = this.paymentdata;
    if (this.languages != null) {
      data['languages'] = this.languages!.toJson();
    }
    if (this.artists != null) {
      data['artists'] = this.artists!.toJson();
    }
    if (this.albums != null) {
      data['albums'] = this.albums!.toJson();
    }
    return data;
  }
}
