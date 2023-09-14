class MetaData {
  String? keyId;

  MetaData({
    this.keyId,
  });

  Map toJson() => {
        "keyId": keyId,
      };

  factory MetaData.fromJson(Map<String, dynamic>? json) {
    return json == null ? MetaData() : MetaData(keyId: json['keyId']);
  }
}
