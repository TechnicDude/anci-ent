class SongalbumModel {
  String? status;
  String? message;
  List<SongalbumData>? data;

  SongalbumModel({this.status, this.message, this.data});

  SongalbumModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SongalbumData>[];
      json['data'].forEach((v) {
        data!.add(new SongalbumData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongalbumData {
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
  Null? categoryId;
  Null? audio;
  Languages? languages;
  Artists? artists;
  Albums? albums;

  SongalbumData(
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
      this.languages,
      this.artists,
      this.albums});

  SongalbumData.fromJson(Map<String, dynamic> json) {
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
    categoryId = json['category_id'];
    audio = json['audio'];
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

class Languages {
  int? id;
  String? name;
  String? shortname;
  String? status;
  String? createdAt;
  String? updatedAt;

  Languages(
      {this.id,
      this.name,
      this.shortname,
      this.status,
      this.createdAt,
      this.updatedAt});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortname = json['shortname'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortname'] = this.shortname;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Artists {
  int? id;
  int? languageId;
  String? artistname;
  String? image;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Artists(
      {this.id,
      this.languageId,
      this.artistname,
      this.image,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Artists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    artistname = json['artistname'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['artistname'] = this.artistname;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
      this.updatedAt});

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
    return data;
  }
}
