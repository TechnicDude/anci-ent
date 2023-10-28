import 'package:ancientmysticmusic/model/albumslistModel.dart';
import 'package:ancientmysticmusic/model/songalbummodel.dart';

class ArtistListModel {
  String? status;
  String? message;
  List<ArtistData>? artistdata;

  ArtistListModel({this.status, this.message, this.artistdata});

  ArtistListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      artistdata = <ArtistData>[];
      json['data'].forEach((v) {
        artistdata!.add(new ArtistData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.artistdata != null) {
      data['data'] = this.artistdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArtistData {
  int? id;
  int? languageId;
  String? artistname;
  String? image;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  Languages? languages;

  ArtistData(
      {this.id,
      this.languageId,
      this.artistname,
      this.image,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.languages});

  ArtistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    artistname = json['artistname'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
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
    if (this.languages != null) {
      data['languages'] = this.languages!.toJson();
    }
    return data;
  }
}
