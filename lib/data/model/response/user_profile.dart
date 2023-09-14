class UserBilling {
  String? address;
  bool? billingAddress;
  String? billingGstNumber;
  String? city;
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
    this.city,
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
        'city': city,
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
      city: json['city'],
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

class UserProfile {
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
  String? customerGstNumber;
  String? storeCode;

  UserProfile({
    this.billing,
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
    this.customerGstNumber,
    this.ratingCount,
    this.storeCode,
  });

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
        'customerGstNumber': customerGstNumber,
        'ratingCount': ratingCount,
        'storeCode': storeCode,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      billing: json['billing'] != null
          ? UserBilling.fromJson(json['billing'])
          : new UserBilling(),
      delivery: json['delivery'] != null
          ? UserDelivery.fromJson(json['delivery'])
          : new UserDelivery(),
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
      customerGstNumber: json['customerGstNumber'],
      ratingCount: json['ratingCount'],
      storeCode: json['storeCode'],
    );
  }
}

class GuestUserProfile {
  UserBilling? userBilling;
  GuestUserProfile({this.userBilling});

  Map toJson() => {
        'billing': userBilling,
      };

  factory GuestUserProfile.fromJson(Map<String, dynamic> json) {
    return GuestUserProfile(
      userBilling: UserBilling.fromJson(json['billing']),
    );
  }
}
