class CouponModel {
  int? _id;
  String? _couponType;
  String? _title;
  String? _code;
  String? _startDate;
  String? _expireDate;
  String? _minPurchase;
  String? _maxDiscount;
  String? _discount;
  String? _discountType;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _descripiton;

  CouponModel(
      {int? id,
      String? couponType,
      String? title,
      String? code,
      String? startDate,
      String? expireDate,
      String? minPurchase,
      String? maxDiscount,
      String? discount,
      String? discountType,
      String? status,
      String? createdAt,
      String? descripiton,
      String? updatedAt}) {
    this._id = id;
    this._couponType = couponType;
    this._title = title;
    this._code = code;
    this._startDate = startDate;
    this._expireDate = expireDate;
    this._minPurchase = minPurchase;
    this._maxDiscount = maxDiscount;
    this._discount = discount;
    this._discountType = discountType;
    this._status = status;
    this._descripiton = descripiton;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get description => _descripiton;
  String? get couponType => _couponType;
  String? get title => _title;
  String? get code => _code;
  String? get startDate => _startDate;
  String? get expireDate => _expireDate;
  String? get minPurchase => _minPurchase;
  String? get maxDiscount => _maxDiscount;
  String? get discount => _discount;
  String? get discountType => _discountType;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  CouponModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _descripiton = json['description'];
    _couponType = json['coupon_type'];
    _title = json['title'];
    _code = json['code'];
    _startDate = json['start_date'];
    _expireDate = json['expire_date'];
    _minPurchase = json['min_purchase'];
    _maxDiscount = json['max_discount'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['description'] = this._descripiton;
    data['coupon_type'] = this._couponType;
    data['title'] = this._title;
    data['code'] = this._code;
    data['start_date'] = this._startDate;
    data['expire_date'] = this._expireDate;
    data['min_purchase'] = this._minPurchase;
    data['max_discount'] = this._maxDiscount;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
