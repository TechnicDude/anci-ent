class CouponListModel {
  String? status;
  String? message;
  List<CouponListModelData>? data;

  CouponListModel({this.status, this.message, this.data});

  CouponListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CouponListModelData>[];
      json['data'].forEach((v) {
        data!.add(new CouponListModelData.fromJson(v));
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

class CouponListModelData {
  int? id;
  String? currentAmount;
  String? couponName;
  String? couponCode;
  String? value;
  String? discountedPrice;
  String? userId;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  CouponListModelData(
      {this.id,
      this.currentAmount,
      this.couponName,
      this.couponCode,
      this.value,
      this.discountedPrice,
      this.userId,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt});

  CouponListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentAmount = json['current_amount'];
    couponName = json['coupon_name'];
    couponCode = json['coupon_code'];
    value = json['value'];
    discountedPrice = json['discounted_price'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_amount'] = this.currentAmount;
    data['coupon_name'] = this.couponName;
    data['coupon_code'] = this.couponCode;
    data['value'] = this.value;
    data['discounted_price'] = this.discountedPrice;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
