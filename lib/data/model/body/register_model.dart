import 'package:shopiana/data/model/response/user_info_model.dart';
import 'package:shopiana/utill/constants.dart';

class RegisterModel {
  UserBilling? billing;
  UserBilling? delivery;
  String? emailAddress;
  String? firstName;
  String? lastName;
  List<Group>? groups = [];
  String? language;
  String? password;
  String? repeatPassword;
  String? storeCode;
  String? userName;

  RegisterModel(
      {this.billing,
      this.delivery,
      this.emailAddress,
      this.firstName,
      this.lastName,
      this.groups,
      this.language,
      this.password,
      this.repeatPassword,
      this.storeCode,
      this.userName});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    billing = json['email'];
    delivery = json['delivery'];
    emailAddress = json['emailAddress'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    groups = json['groups'];
    language = json['language'];
    password = json['password'];
    repeatPassword = json['repeatPassword'];
    storeCode = json['storeCode'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.billing != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    data['emailAddress'] = this.emailAddress;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.groups != null) {
      data['groups'] = this.groups!.map((group) => group.toJson()).toList();
    }
    data['language'] = this.language;
    data['password'] = this.password;
    data['repeatPassword'] = this.repeatPassword;
    data['storeCode'] = this.storeCode;
    data['userName'] = this.userName;
    return data;
  }
}

class Group {
  String? name = Constants.CUSTOMER_ROLE;
  String? type = Constants.CUSTOMER_ROLE;

  Group({this.name, this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }
}
