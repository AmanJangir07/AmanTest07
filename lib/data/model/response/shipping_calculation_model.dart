class ShippingCalculation {
  ShippingCalculation({
    this.shipping,
    this.handling,
    this.shippingModule,
    this.shippingOption,
    this.freeShipping,
    this.taxOnShipping,
    this.shippingQuote,
    this.shippingText,
    this.handlingText,
    this.delivery,
    this.selectedShippingOption,
    this.shippingOptions,
    this.quoteInformations,
  });

  double? shipping;
  double? handling;
  String? shippingModule;
  String? shippingOption;
  bool? freeShipping;
  bool? taxOnShipping;
  bool? shippingQuote;
  String? shippingText;
  String? handlingText;
  Delivery? delivery;
  dynamic selectedShippingOption;
  List<ShippingOption>? shippingOptions;
  QuoteInformations? quoteInformations;

  factory ShippingCalculation.fromJson(Map<String, dynamic>? json) =>
      json == null
          ? ShippingCalculation()
          : ShippingCalculation(
              shipping: json["shipping"],
              handling: json["handling"],
              shippingModule: json["shippingModule"],
              shippingOption: json["shippingOption"],
              freeShipping: json["freeShipping"],
              taxOnShipping: json["taxOnShipping"],
              shippingQuote: json["shippingQuote"],
              shippingText: json["shippingText"],
              handlingText: json["handlingText"],
              delivery: Delivery.fromJson(json["delivery"]),
              selectedShippingOption: json["selectedShippingOption"],
              shippingOptions: json["shippingOptions"] == null
                  ? null
                  : List<ShippingOption>.from(json["shippingOptions"]
                      .map((x) => ShippingOption.fromJson(x))),
              quoteInformations:
                  QuoteInformations.fromJson(json["quoteInformations"]),
            );

  Map<String, dynamic> toJson() => {
        "shipping": shipping,
        "handling": handling,
        "shippingModule": shippingModule,
        "shippingOption": shippingOption,
        "freeShipping": freeShipping,
        "taxOnShipping": taxOnShipping,
        "shippingQuote": shippingQuote,
        "shippingText": shippingText,
        "handlingText": handlingText,
        "delivery": delivery!.toJson(),
        "selectedShippingOption": selectedShippingOption,
        "shippingOptions":
            List<dynamic>.from(shippingOptions!.map((x) => x.toJson())),
        "quoteInformations": quoteInformations!.toJson(),
      };
}

class Delivery {
  Delivery({
    this.postalCode,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.bilstateOther,
    this.company,
    this.phone,
    this.address,
    this.city,
    this.stateProvince,
    this.billingAddress,
    this.latitude,
    this.longitude,
    this.zone,
    this.country,
    this.countryName,
    this.provinceName,
  });

  String? postalCode;
  dynamic countryCode;
  dynamic firstName;
  dynamic lastName;
  dynamic bilstateOther;
  dynamic company;
  dynamic phone;
  dynamic address;
  dynamic city;
  String? stateProvince;
  bool? billingAddress;
  dynamic latitude;
  dynamic longitude;
  String? zone;
  String? country;
  dynamic countryName;
  dynamic provinceName;

  factory Delivery.fromJson(Map<String, dynamic>? json) => json == null
      ? Delivery()
      : Delivery(
          postalCode: json["postalCode"],
          countryCode: json["countryCode"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          bilstateOther: json["bilstateOther"],
          company: json["company"],
          phone: json["phone"],
          address: json["address"],
          city: json["city"],
          stateProvince: json["stateProvince"],
          billingAddress: json["billingAddress"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          zone: json["zone"],
          country: json["country"],
          countryName: json["countryName"],
          provinceName: json["provinceName"],
        );

  Map<String, dynamic> toJson() => {
        "postalCode": postalCode,
        "countryCode": countryCode,
        "firstName": firstName,
        "lastName": lastName,
        "bilstateOther": bilstateOther,
        "company": company,
        "phone": phone,
        "address": address,
        "city": city,
        "stateProvince": stateProvince,
        "billingAddress": billingAddress,
        "latitude": latitude,
        "longitude": longitude,
        "zone": zone,
        "country": country,
        "countryName": countryName,
        "provinceName": provinceName,
      };
}

class QuoteInformations {
  QuoteInformations();

  factory QuoteInformations.fromJson(Map<String, dynamic>? json) =>
      QuoteInformations();

  Map<String, dynamic> toJson() => {};
}

class ShippingOption {
  ShippingOption({
    this.optionPrice,
    this.shippingQuoteOptionId,
    this.optionName,
    this.optionCode,
    this.optionDeliveryDate,
    this.optionShippingDate,
    this.optionPriceText,
    this.optionId,
    this.description,
    this.shippingModuleCode,
    this.note,
    this.estimatedNumberOfDays,
  });

  double? optionPrice;
  int? shippingQuoteOptionId;
  String? optionName;
  String? optionCode;
  dynamic optionDeliveryDate;
  dynamic optionShippingDate;
  String? optionPriceText;
  String? optionId;
  String? description;
  String? shippingModuleCode;
  String? note;
  dynamic estimatedNumberOfDays;

  factory ShippingOption.fromJson(Map<String, dynamic> json) => json == null
      ? ShippingOption()
      : ShippingOption(
          optionPrice: json["optionPrice"],
          shippingQuoteOptionId: json["shippingQuoteOptionId"],
          optionName: json["optionName"],
          optionCode: json["optionCode"],
          optionDeliveryDate: json["optionDeliveryDate"],
          optionShippingDate: json["optionShippingDate"],
          optionPriceText: json["optionPriceText"],
          optionId: json["optionId"],
          description: json["description"],
          shippingModuleCode: json["shippingModuleCode"],
          note: json["note"],
          estimatedNumberOfDays: json["estimatedNumberOfDays"],
        );

  Map<String, dynamic> toJson() => {
        "optionPrice": optionPrice,
        "shippingQuoteOptionId": shippingQuoteOptionId,
        "optionName": optionName,
        "optionCode": optionCode,
        "optionDeliveryDate": optionDeliveryDate,
        "optionShippingDate": optionShippingDate,
        "optionPriceText": optionPriceText,
        "optionId": optionId,
        "description": description,
        "shippingModuleCode": shippingModuleCode,
        "note": note,
        "estimatedNumberOfDays": estimatedNumberOfDays,
      };
}
