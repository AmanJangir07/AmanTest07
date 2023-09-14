import 'package:shopiana/data/model/body/state_master_model.dart';

class CountryMasterModel {
  int? id;
  String? code;
  bool? supported;
  String? name;
  List<StateMasterModel>? zones;

  CountryMasterModel(
      {this.id, this.code, this.supported, this.name, this.zones});

  factory CountryMasterModel.fromJson(Map<String, dynamic> json) {
    return CountryMasterModel(
        id: json['id'],
        code: json['code'],
        supported: json['supported'],
        name: json['name'],
        zones: (json['zones'] as List<dynamic>)
            .map((zone) => StateMasterModel.fromJson(zone))
            .toList());
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['code'] = this.code;
  //   data['supported'] = this.supported;
  //   data['name'] = this.name;
  //   data['zones'] = StateMasterModel.to;
  //   return data;
  // }
}
