class PaymentModule {
  String? code;
  bool? active;
  bool? configured;
  String? image;

  PaymentModule(
    this.code,
    this.active,
    this.configured,
    this.image,
  );

  PaymentModule.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    active = json['active'];
    configured = json['configured'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['active'] = this.active;
    data['configured'] = this.configured;
    data['image'] = this.image;

    return data;
  }
}
