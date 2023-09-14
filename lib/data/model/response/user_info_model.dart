// class UserInfoModel {
//   int id;
//   String name;
//   String method;
//   String fName;
//   String lName;
//   String phone;
//   String image;
//   String email;
//   String emailVerifiedAt;
//   String createdAt;
//   String updatedAt;

//   UserInfoModel(
//       {this.id, this.name, this.method, this.fName, this.lName, this.phone, this.image, this.email, this.emailVerifiedAt, this.createdAt, this.updatedAt});

//   UserInfoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     method = json['_method'];
//     fName = json['f_name'];
//     lName = json['l_name'];
//     phone = json['phone'];
//     image = json['image'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['_method'] = this.method;
//     data['f_name'] = this.fName;
//     data['l_name'] = this.lName;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// import 'package:lexagro/models/address.dart';

class UserBilling {
  String? address;
  bool? billingAddress;
  String? billingGstNumber;
  String? bilstateOther;
  String? city;
  String? district;
  String? company;
  String? country;
  String? countryCode;
  String? firstName;
  String? lastName;
  String? latitude;
  String? longitude;
  String? phone;
  String? postalCode;
  String? stateProvince;
  String? zone;
  UserBilling({
    this.address,
    this.billingAddress,
    this.billingGstNumber,
    this.bilstateOther,
    this.city,
    this.district,
    this.company,
    this.country,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.latitude,
    this.longitude,
    this.phone,
    this.postalCode,
    this.stateProvince,
    this.zone,
  });

  Map toJson() => {
        'address': address,
        'billingAddress': billingAddress,
        'billingGstNumber': billingGstNumber,
        'bilstateOther': bilstateOther,
        'city': city,
        'district': district,
        'company': company,
        'country': country,
        'countryCode': countryCode,
        'firstName': firstName,
        'lastName': lastName,
        'latitude': latitude,
        'longitude': longitude,
        'phone': phone,
        'postalCode': postalCode,
        'stateProvince': stateProvince,
        'zone': zone,
      };
  factory UserBilling.fromJson(Map<String, dynamic> json) {
    return UserBilling(
      address: json['address'],
      billingAddress: json['billingAddress'],
      billingGstNumber: json['billingGstNumber'],
      bilstateOther: json['bilstateOther'],
      city: json['city'],
      district: json['district'],
      company: json['company'],
      country: json['country'],
      countryCode: json['countryCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
      postalCode: json['postalCode'],
      stateProvince: json['stateProvince'],
      zone: json['zone'],
    );
  }
}

class UserDelivery {
  String? address;
  bool? billingAddress;
  String? bilstateOther;
  String? city;
  String? district;
  String? company;
  String? country;
  String? countryCode;
  String? firstName;
  String? lastName;
  String? latitude;
  String? longitude;
  String? phone;
  String? postalCode;
  String? stateProvince;
  String? zone;
  UserDelivery({
    this.address,
    this.billingAddress,
    this.bilstateOther,
    this.city,
    this.district,
    this.company,
    this.country,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.latitude,
    this.longitude,
    this.phone,
    this.postalCode,
    this.stateProvince,
    this.zone,
  });
  Map toJson() => {
        'address': address,
        'billingAddress': billingAddress,
        'bilstateOther': bilstateOther,
        'city': city,
        'district': district,
        'company': company,
        'country': country,
        'countryCode': countryCode,
        'firstName': firstName,
        'lastName': lastName,
        'latitude': latitude,
        'longitude': longitude,
        'phone': phone,
        'postalCode': postalCode,
        'stateProvince': stateProvince,
        'zone': zone,
      };

  factory UserDelivery.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? UserDelivery()
        : UserDelivery(
            address: json['address'],
            billingAddress: json['billingAddress'],
            bilstateOther: json['bilstateOther'],
            city: json['city'],
            district: json['district'],
            company: json['company'],
            country: json['country'],
            countryCode: json['countryCode'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            latitude: json['latitude'],
            longitude: json['longitude'],
            phone: json['phone'],
            postalCode: json['postalCode'],
            stateProvince: json['stateProvince'],
            zone: json['zone'],
          );
  }
}

class NewUserGroup {
  String? name;
  String? type;
  NewUserGroup({this.name, this.type});
  Map toJson() => {
        'name': name,
        'type': type,
      };
  factory NewUserGroup.fromJson(Map<String, dynamic> json) {
    return NewUserGroup(
      name: json['name'],
      type: json['type'],
    );
  }
}

class UserInfoModel {
  UserBilling? billing;
  UserDelivery? delivery;
  List<NewUserGroup>? groups;
  final int? id;
  String? emailAddress;
  String? userName;
  String? firstName;
  String? lastName;
  String? gender;
  String? language;
  String? provider;
  double? rating;
  int? ratingCount;
  String? storeCode;
  String? password;
  String? repeatPassword;

  UserInfoModel(
      {this.billing,
      this.delivery,
      this.groups,
      this.id,
      this.emailAddress,
      this.userName,
      this.firstName,
      this.lastName,
      this.gender,
      this.language,
      this.provider,
      this.rating,
      this.ratingCount,
      this.storeCode,
      this.password,
      this.repeatPassword});

  Map toJson() => {
        'billing': billing,
        'delivery': delivery,
        'groups': groups,
        'id': id,
        'emailAddress': emailAddress,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'language': language,
        'provider': provider,
        'rating': rating,
        'ratingCount': ratingCount,
        'storeCode': storeCode,
        'password': password,
        'repeatPassword': repeatPassword,
      };

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      billing: UserBilling.fromJson(json['billing']),
      delivery: UserDelivery.fromJson(json['delivery']),
      groups: (json['groups'] as List<dynamic>)
          .map((group) => NewUserGroup.fromJson(group))
          .toList(),
      id: json['id'],
      emailAddress: json['emailAddress'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      language: json['language'],
      provider: json['provider'],
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      storeCode: json['storeCode'],
      password: json['password'],
      repeatPassword: json['repeatPassword'],
    );
  }
}
