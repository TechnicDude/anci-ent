class StorelikebyuserModel {
  String? status;
  String? message;
  StorelikebyuserData? data;

  StorelikebyuserModel({this.status, this.message, this.data});

  StorelikebyuserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new StorelikebyuserData.fromJson(json['data'])
        : null;
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

class StorelikebyuserData {
  List<Album>? album;
  List<Song>? song;

  StorelikebyuserData({this.album, this.song});

  StorelikebyuserData.fromJson(Map<String, dynamic> json) {
    if (json['album'] != null) {
      album = <Album>[];
      json['album'].forEach((v) {
        album!.add(new Album.fromJson(v));
      });
    }
    if (json['song'] != null) {
      song = <Song>[];
      json['song'].forEach((v) {
        song!.add(new Song.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    if (this.song != null) {
      data['song'] = this.song!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Album {
  int? id;
  int? albumId;
  Null? songId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Albums? albums;

  Album(
      {this.id,
      this.albumId,
      this.songId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.albums});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumId = json['album_id'];
    songId = json['song_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    albums =
        json['albums'] != null ? new Albums.fromJson(json['albums']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.albums != null) {
      data['albums'] = this.albums!.toJson();
    }
    return data;
  }
}

class Albums {
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
  double? price;
  String? paymentStatus;

  Albums(
      {this.id,
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
      this.paymentStatus});

  Albums.fromJson(Map<String, dynamic> json) {
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
    price = double.parse(json['price'].toString());
    paymentStatus = json['payment_status'];
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
    return data;
  }
}

class Song {
  int? id;
  int? albumId;
  String? songId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Null? songs;

  Song(
      {this.id,
      this.albumId,
      this.songId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.songs});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumId = json['album_id'];
    songId = json['song_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    songs = json['songs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['songs'] = this.songs;
    return data;
  }
}
