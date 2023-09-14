class MasterItem {
  MasterItem({
    this.id,
    this.itemValue,
    this.itemName,
    this.itemKey,
    this.comment,
    this.itemType,
    this.active,
    this.merchantId,
    this.language,
  });

  int? id;
  String? itemValue;
  String? itemName;
  String? itemKey;
  String? comment;
  String? itemType;
  bool? active;
  int? merchantId;
  Language? language;

  factory MasterItem.fromJson(Map<String, dynamic> json) => MasterItem(
        id: json["id"],
        itemValue: json["itemValue"],
        itemName: json["itemName"],
        itemKey: json["itemKey"],
        comment: json["comment"],
        itemType: json["itemType"],
        active: json["active"],
        merchantId: json["merchantId"],
        language: Language.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemValue": itemValue,
        "itemName": itemName,
        "itemKey": itemKey,
        "comment": comment,
        "itemType": itemType,
        "active": active,
        "merchantId": merchantId,
        "language": language!.toJson(),
      };
}

class Language {
  Language({
    this.id,
    this.code,
    this.languageNew,
  });

  int? id;
  String? code;
  bool? languageNew;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        code: json["code"],
        languageNew: json["new"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "new": languageNew,
      };
}
