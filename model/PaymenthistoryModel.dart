class PaymenthistoryModel {
  String? status;
  String? message;
  List<PaymenthistoryData>? data;

  PaymenthistoryModel({this.status, this.message, this.data});

  PaymenthistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymenthistoryData>[];
      json['data'].forEach((v) {
        data!.add(new PaymenthistoryData.fromJson(v));
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

class PaymenthistoryData {
  int? id;
  int? cartId;
  int? albumId;
  int? songId;
  int? userId;
  int? amount;
  String? paymentMethod;
  String? currency;
  String? chargeIdOrToken;
  String? payerEmail;
  String? localTransactionId;
  String? paymentCreated;
  String? status;
  String? createdAt;
  String? updatedAt;
  Albums? albums;
  String? songs;

  PaymenthistoryData(
      {this.id,
      this.cartId,
      this.albumId,
      this.songId,
      this.userId,
      this.amount,
      this.paymentMethod,
      this.currency,
      this.chargeIdOrToken,
      this.payerEmail,
      this.localTransactionId,
      this.paymentCreated,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.albums,
      this.songs});

  PaymenthistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    albumId = json['album_id'];
    songId = json['song_id'];
    userId = json['user_id'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    currency = json['currency'];
    chargeIdOrToken = json['charge_id_or_token'];
    payerEmail = json['payer_email'];
    localTransactionId = json['local_transaction_id'];
    paymentCreated = json['payment_created'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    albums =
        json['albums'] != null ? new Albums.fromJson(json['albums']) : null;
    songs = json['songs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['album_id'] = this.albumId;
    data['song_id'] = this.songId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['currency'] = this.currency;
    data['charge_id_or_token'] = this.chargeIdOrToken;
    data['payer_email'] = this.payerEmail;
    data['local_transaction_id'] = this.localTransactionId;
    data['payment_created'] = this.paymentCreated;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.albums != null) {
      data['albums'] = this.albums!.toJson();
    }
    data['songs'] = this.songs;
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
  int? price;

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
      this.price});

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
    price = json['price'];
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
    return data;
  }
}
