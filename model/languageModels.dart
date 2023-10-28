class LanguageModelss {
  String? status;
  String? message;
  List<LanguageModelsData>? languageModelsdata;

  LanguageModelss({this.status, this.message, this.languageModelsdata});

  LanguageModelss.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      languageModelsdata = <LanguageModelsData>[];
      json['data'].forEach((v) {
        languageModelsdata!.add(new LanguageModelsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.languageModelsdata != null) {
      data['data'] = this.languageModelsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageModelsData {
  int? id;
  String? name;
  String? shortname;
  String? status;
  String? createdAt;
  String? updatedAt;

  LanguageModelsData(
      {this.id,
      this.name,
      this.shortname,
      this.status,
      this.createdAt,
      this.updatedAt});

  LanguageModelsData.fromJson(Map<String, dynamic> json) {
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
