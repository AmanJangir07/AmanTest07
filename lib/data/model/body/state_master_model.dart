class StateMasterModel {
  int? id;
  String? countryCode;
  String? code;
  String? name;

  StateMasterModel({
    this.id,
    this.countryCode,
    this.code,
    this.name,
  });

  factory StateMasterModel.fromJson(Map<String, dynamic> json) {
    return StateMasterModel(
      id: json['id'],
      countryCode: json['countryCode'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['countryCode'] = this.countryCode;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
