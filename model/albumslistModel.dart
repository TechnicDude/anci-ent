import 'package:ancientmysticmusic/model/categoriesmodel.dart';
import 'package:ancientmysticmusic/model/songalbummodel.dart';
import 'package:ancientmysticmusic/model/songlistbyartistmodel.dart';

class AlbumsListModel {
  String? status;
  String? message;
  List<AlbumData>? albumdata;
  List<SongAlbumList>? songdata;

  AlbumsListModel({this.status, this.message, this.albumdata});

  AlbumsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      albumdata = <AlbumData>[];
      json['data'].forEach((v) {
        albumdata!.add(new AlbumData.fromJson(v));
      });
    }
    if (json['song'] != null) {
      songdata = <SongAlbumList>[];
      json['song'].forEach((v) {
        songdata!.add(new SongAlbumList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.albumdata != null) {
      data['data'] = this.albumdata!.map((v) => v.toJson()).toList();
    }
    if (this.songdata != null) {
      data['song'] = this.songdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlbumData {
  int? id;
  int? languageId;
  int? categoryId;
  String? title;
  String? year;
  String? image;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? price;
  String? paymentStatus;
  int? songsCount;
  Languages? languages;
  CategoriesData? categories;
  String? likes;
  String? payment_data;
  // "likes": "yes"

  AlbumData({
    this.id,
    this.languageId,
    this.categoryId,
    this.title,
    this.year,
    this.image,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.paymentStatus,
    this.songsCount,
    this.languages,
    this.categories,
    this.likes,
    this.payment_data,
  });

  AlbumData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    categoryId = json['category_id'];
    title = json['title'];
    year = json['year'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    paymentStatus = json['payment_status'];
    songsCount = json['songs_count'];
    payment_data = json['payment_data'];
    likes = json['likes'].toString().toLowerCase() == "null"
        ? "no"
        : json['likes'].toString();
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
    categories = json['categories'] != null
        ? new CategoriesData.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['year'] = this.year;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['payment_status'] = this.paymentStatus;
    data['songs_count'] = this.songsCount;
    data['likes'] = this.likes;
    data['payment_data'] = this.payment_data;
    if (this.languages != null) {
      data['languages'] = this.languages!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}
