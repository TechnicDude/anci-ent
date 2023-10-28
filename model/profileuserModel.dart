class ProfileUserModel {
  String? status;
  String? message;
  ProfileUserData? data;

  ProfileUserModel({this.status, this.message, this.data});

  ProfileUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new ProfileUserData.fromJson(json['data'])
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

class ProfileUserData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? apiToken;
  String? createdAt;
  String? updatedAt;
  String? contact;
  String? image;
  String? country;
  String? otp;
  String? verified;
  String? socialId;
  String? socialType;

  ProfileUserData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.apiToken,
      this.createdAt,
      this.updatedAt,
      this.contact,
      this.image,
      this.country,
      this.otp,
      this.verified,
      this.socialId,
      this.socialType});

  ProfileUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'].toString();
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contact = json['contact'];
    image = json['image'];
    country = json['country'];
    otp = json['otp'];
    verified = json['verified'];
    socialId = json['social_id'];
    socialType = json['social_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['api_token'] = this.apiToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['country'] = this.country;
    data['otp'] = this.otp;
    data['verified'] = this.verified;
    data['social_id'] = this.socialId;
    data['social_type'] = this.socialType;
    return data;
  }
}
